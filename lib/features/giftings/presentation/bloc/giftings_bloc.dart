// ignore: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../../core/error/failures.dart';
import '../../domain/entities/gift_item.dart';
import '../../domain/usecases/create_gift.dart';
import '../../domain/usecases/delete_gift.dart';
import '../../domain/usecases/get_all_barters.dart';
import '../../domain/usecases/get_gift.dart';
import '../../domain/usecases/update_gift.dart';

part 'giftings_event.dart';
part 'giftings_state.dart';

class GiftingsBloc extends Bloc<GiftingsEvent, GiftingsState> {
  final CreateGift createGift;
  final DeleteGift deleteGift;
  final GetAllGifts getAllGifts;
  final GetGift getGift;
  final UpdateGift updateGift;

  GiftingsBloc({
    required this.createGift,
    required this.deleteGift,
    required this.getAllGifts,
    required this.getGift,
    required this.updateGift,
  }) : super(const GiftingsState()) {
    on<FetchGiftEvent>(onFetchItem);
    on<FetchGiftsEvent>(onFetchItemsEvent, transformer: (events, mapper) {
      return events
          .debounce(
            const Duration(milliseconds: 2000),
          )
          .asyncExpand((mapper));
    });
  }

  //FETCH AND DISPLAY A SINGLE GIFT
  void onFetchItem(FetchGiftEvent event, Emitter<GiftingsState> emit) async {
    emit(state.copyWith(
        item: state.items[0], giftPageStatus: GiftingsPageStatus.giftLoaded));
    // final result = await getGift(id: event.id);

    // result!.fold((l) async {}, (r) async {
    //   emit(
    //     state.copyWith(item: r, giftPageStatus: GiftingsPageStatus.giftLoaded),
    //   );
    // });
  }

  // FETCH MULTIPLE GIFTS

  void onFetchItemsEvent(
      FetchGiftsEvent event, Emitter<GiftingsState> emit) async {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.loading,
        ),
      );
    }

    final result = await getAllGifts(state.items.length);

    result!.fold(
      (l) async {},
      (r) async {
        //handle the initial or empty state
        if (state.items.isEmpty) {
          fetchItemsInitial(r, emit);
        } else {
          //handle the loaded state
          fetchItemsPostInitial(r, emit);
        }
      },
    );
  }

  void fetchItemsFailure(Failure failure, Emitter<GiftingsState> emit) {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.initialError,
          errorMessage: failure.message,
        ),
      );
    } else {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.error,
          errorMessage: failure.message,
        ),
      );
    }
  }

  void fetchItemsInitial(List<Gift>? result, Emitter<GiftingsState> emit) {
    if (result == null) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.initialError,
          errorMessage: 'Something went wrong',
        ),
      );
    } else if (result.isEmpty) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.empty,
        ),
      );
    } else if (result.isNotEmpty) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.loaded,
          items: result,
        ),
      );
    }
  }

  void fetchItemsPostInitial(List<Gift>? result, Emitter<GiftingsState> emit) {
    if (result == null) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.error,
        ),
      );
    } else if (result.isEmpty) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.loaded,
        ),
      );
    } else if (result.isNotEmpty) {
      emit(
        state.copyWith(
          giftingsPageStatus: GiftingsPageStatus.loaded,
          items: state.items + result,
        ),
      );
      print(state.items.length);
    }
  }

  // FETCH SINGLE GIFT

}
