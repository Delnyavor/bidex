part of 'auction_bloc.dart';

class AuctionState extends Equatable {
  final AuctionPageStatus auctionPageStatus;
  final List<AuctionItem> items;
  final AuctionItem? item;
  final String errorMessage;
  final bool hasReachedMax;

  const AuctionState({
    this.auctionPageStatus = AuctionPageStatus.loading,
    this.items = const [],
    this.item,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  AuctionState copyWith(
      {AuctionPageStatus? auctionPageStatus,
      List<AuctionItem>? items,
      AuctionItem? item,
      String? errorMessage,
      bool? hasReachedMax}) {
    return AuctionState(
      auctionPageStatus: auctionPageStatus ?? this.auctionPageStatus,
      items: items ?? this.items,
      item: item ?? this.item,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props =>
      [auctionPageStatus, items, item, errorMessage, hasReachedMax];
}

enum AuctionPageStatus {
  loading,
  loaded,
  empty,
  error,
  initialError,
  auctionLoading,
  auctionLoaded,
  auctionEmpty,
  auctionError,
}
