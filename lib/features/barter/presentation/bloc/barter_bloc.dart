import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/features/barter/domain/usecases/get_all_barters.dart';
import 'package:bidex/features/barter/domain/usecases/get_barter.dart';
import 'package:bidex/features/barter/domain/usecases/update_barter.dart';
import 'package:bidex/features/barter/domain/usecases/create_barter.dart';
import 'package:bidex/features/barter/domain/usecases/delete_barter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:stream_transform/stream_transform.dart';

part 'barter_event.dart';
part 'barter_state.dart';

class BarterBloc extends Bloc<BarterEvent, BarterState> {
  final GetAllBarters getAllBarters;
  final GetBarter getBarter;
  final CreateBarter createBarter;
  final DeleteBarter deleteBarter;
  final UpdateBarter updateBarter;
  final LocalAuthSource localAuthSource;

  BarterBloc({
    required this.getAllBarters,
    required this.getBarter,
    required this.createBarter,
    required this.deleteBarter,
    required this.updateBarter,
    required this.localAuthSource,
  }) : super(const BarterState()) {
    on<FetchBarterItems>(onFetchItemsEvent, transformer: (events, mapper) {
      return events
          .debounce(
            const Duration(milliseconds: 1000),
            // leading: false,
          )
          .asyncExpand((mapper));
    });

    on<CreateBarterEvent>(onCreateBarterEvent);
    on<InitBarterCreation>(onInitCreationPage);
  }

  void onInitCreationPage(InitBarterCreation event, Emitter<BarterState> emit) {
    emit(state.copyWith(createBarterStatus: CreateBarterStatus.initial));
  }

  void onCreateBarterEvent(
      CreateBarterEvent event, Emitter<BarterState> emit) async {
    User user = await localAuthSource.getUser();
    final result = await createBarter(
      barterItem: event.item,
      authToken: user.idToken,
      refreshToken: user.refreshToken,
    );

    if (result is Failure) {
      emit(
        state.copyWith(createBarterStatus: CreateBarterStatus.creationError),
      );
    } else {
      emit(
        state.copyWith(createBarterStatus: CreateBarterStatus.creationSuccess),
      );
    }
  }

  void onFetchItemsEvent(
      FetchBarterItems event, Emitter<BarterState> emit) async {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.loading,
        ),
      );
    }
    final result = await getAllBarters(state.items.length);

    result!.fold((l) async {}, (r) async {
      //handle the initial or empty state
      if (state.items.isEmpty) {
        handleInitial(r, emit);
      } else {
        //handle the loaded state
        handleNonInitial(r, emit);
      }
    });
  }

  void handleFailure(Failure failure, Emitter<BarterState> emit) {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.initialError,
          errorMessage: failure.message,
        ),
      );
    } else {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.error,
          errorMessage: failure.message,
        ),
      );
    }
  }

  void handleInitial(List<BarterItem>? result, Emitter<BarterState> emit) {
    if (result == null) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.initialError,
          errorMessage: 'Something went wrong',
        ),
      );
    } else if (result.isEmpty) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.empty,
        ),
      );
    } else if (result.isNotEmpty) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.loaded,
          items: result,
        ),
      );
    }
  }

  void handleNonInitial(List<BarterItem>? result, Emitter<BarterState> emit) {
    if (result == null) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.error,
        ),
      );
    } else if (result.isEmpty) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.loaded,
        ),
      );
    } else if (result.isNotEmpty) {
      emit(
        state.copyWith(
          barterPageStatus: BarterPageStatus.loaded,
          items: state.items + result,
        ),
      );
      print(state.items.length);
    }
  }
}
