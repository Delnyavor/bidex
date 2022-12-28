import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/features/barter/domain/usecases/get_all_barters.dart';
import 'package:bidex/features/barter/domain/usecases/get_barter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'barter_event.dart';
part 'barter_state.dart';

class BarterBloc extends Bloc<BarterEvent, BarterState> {
  final GetAllBarters getAllBarters;
  final GetBarterItem getBarterItem;
  final CreateBarterItem createBarterItem;
  final DeleteBarterItem deleteBarterItem;
  final UpdateBarterItem updateBarterItem;

  BarterBloc({
    required this.getAllBarters,
    required this.getBarterItem,
    required this.createBarterItem,
    required this.deleteBarterItem,
    required this.updateBarterItem,
  }) : super(const BarterState()) {
    on<FetchBarterItems>((event, emit) {});
  }

  void onFetchItemsEvent(BarterEvent event, Emitter<BarterState> emit) async {
    emit(
      state.copyWith(barterPageStatus: BarterPageStatus.loading),
    );
    final result = await getAllBarters();

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
    if (state.barterPageStatus == BarterPageStatus.initial) {
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
          items: state.items..addAll(result),
        ),
      );
    }
  }
}
