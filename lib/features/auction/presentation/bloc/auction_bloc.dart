import 'package:bidex/features/auction/domain/entities/auction_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/create_auction.dart';
import '../../domain/usecases/delete_auction.dart';
import '../../domain/usecases/get_all_auctions.dart';
import '../../domain/usecases/get_auction.dart';
import '../../domain/usecases/update_auction.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  final CreateAuction createAuction;
  final DeleteAuction deleteAuction;
  final GetAllAuctions getAllAuctions;
  final GetAuction getAuction;
  final UpdateAuction updateAuction;

  AuctionBloc({
    required this.createAuction,
    required this.deleteAuction,
    required this.getAllAuctions,
    required this.getAuction,
    required this.updateAuction,
  }) : super(const AuctionState()) {
    on<FetchAuctionEvent>(onFetchItem);
    on<FetchAuctionsEvent>(onFetchItemsEvent, transformer: (events, mapper) {
      return events
          .debounce(
            const Duration(milliseconds: 2000),
          )
          .asyncExpand((mapper));
    });
  }

  //FETCH AND DISPLAY A SINGLE Auction
  void onFetchItem(FetchAuctionEvent event, Emitter<AuctionState> emit) async {
    emit(state.copyWith(
        item: state.items[0],
        auctionPageStatus: AuctionPageStatus.auctionLoaded));
    // final result = await getAuction(id: event.id);

    // result!.fold((l) async {}, (r) async {
    //   emit(
    //     state.copyWith(item: r, AuctionPageStatus: AuctionPageStatus.AuctionLoaded),
    //   );
    // });
  }

  // FETCH MULTIPLE AuctionS

  void onFetchItemsEvent(
      FetchAuctionsEvent event, Emitter<AuctionState> emit) async {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.loading,
        ),
      );
    }

    final result = await getAllAuctions(state.items.length);

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

  void fetchItemsFailure(Failure failure, Emitter<AuctionState> emit) {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.initialError,
          errorMessage: failure.message,
        ),
      );
    } else {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.error,
          errorMessage: failure.message,
        ),
      );
    }
  }

  void fetchItemsInitial(
      List<AuctionItem>? result, Emitter<AuctionState> emit) {
    if (result == null) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.initialError,
          errorMessage: 'Something went wrong',
        ),
      );
    } else if (result.isEmpty) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.empty,
        ),
      );
    } else if (result.isNotEmpty) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.loaded,
          items: result,
        ),
      );
    }
  }

  void fetchItemsPostInitial(
      List<AuctionItem>? result, Emitter<AuctionState> emit) {
    if (result == null) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.error,
        ),
      );
    } else if (result.isEmpty) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.loaded,
        ),
      );
    } else if (result.isNotEmpty) {
      emit(
        state.copyWith(
          auctionPageStatus: AuctionPageStatus.loaded,
          items: state.items + result,
        ),
      );
      print(state.items.length);
    }
  }
}
