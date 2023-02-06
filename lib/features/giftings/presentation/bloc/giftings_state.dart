part of 'giftings_bloc.dart';

class GiftingsState extends Equatable {
  final GiftingsPageStatus giftingsPageStatus;
  final GiftingsPageStatus giftPageStatus;
  final List<Gift> items;
  final Gift? item;
  final String errorMessage;
  final bool hasReachedMax;

  const GiftingsState({
    this.giftingsPageStatus = GiftingsPageStatus.loading,
    this.giftPageStatus = GiftingsPageStatus.loading,
    this.items = const [],
    this.item,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  GiftingsState copyWith(
      {GiftingsPageStatus? giftingsPageStatus,
      GiftingsPageStatus? giftPageStatus,
      List<Gift>? items,
      Gift? item,
      String? errorMessage,
      bool? hasReachedMax}) {
    return GiftingsState(
      giftingsPageStatus: giftingsPageStatus ?? this.giftingsPageStatus,
      giftPageStatus: giftPageStatus ?? this.giftPageStatus,
      items: items ?? this.items,
      item: item ?? this.item,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props =>
      [giftingsPageStatus, items, item, errorMessage, hasReachedMax];
}

enum GiftingsPageStatus {
  loading,
  loaded,
  empty,
  error,
  initialError,
  giftLoading,
  giftLoaded,
  giftEmpty,
  giftError,
}
