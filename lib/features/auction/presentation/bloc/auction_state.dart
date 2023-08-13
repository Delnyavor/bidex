part of 'auction_bloc.dart';

class AuctionState extends Equatable {
  final AuctionPageStatus auctionPageStatus;
  final CreateAuctionStatus createAuctionStatus;
  final List<AuctionItem> items;
  final AuctionItem? item;
  final String errorMessage;
  final bool hasReachedMax;

  const AuctionState({
    this.auctionPageStatus = AuctionPageStatus.loading,
    this.createAuctionStatus = CreateAuctionStatus.initial,
    this.items = const [],
    this.item,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  AuctionState copyWith(
      {AuctionPageStatus? auctionPageStatus,
      CreateAuctionStatus? createAuctionStatus,
      List<AuctionItem>? items,
      AuctionItem? item,
      String? errorMessage,
      bool? hasReachedMax}) {
    return AuctionState(
      auctionPageStatus: auctionPageStatus ?? this.auctionPageStatus,
      createAuctionStatus: createAuctionStatus ?? this.createAuctionStatus,
      items: items ?? this.items,
      item: item ?? this.item,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        auctionPageStatus,
        items,
        item,
        errorMessage,
        hasReachedMax,
        createAuctionStatus
      ];
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

enum CreateAuctionStatus {
  initial,
  creationSuccess,
  creationError,
}
