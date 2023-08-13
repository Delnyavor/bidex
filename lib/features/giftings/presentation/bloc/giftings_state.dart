part of 'giftings_bloc.dart';

class GiftingsState extends Equatable {
  final GiftingsPageStatus giftingsPageStatus;
  final GiftingsPageStatus giftPageStatus;
  final CreateGiftStatus createGiftStatus;
  final List<Gift> items;
  final Gift? item;
  final String errorMessage;
  final bool hasReachedMax;

  const GiftingsState({
    this.giftingsPageStatus = GiftingsPageStatus.loading,
    this.giftPageStatus = GiftingsPageStatus.loading,
    this.createGiftStatus = CreateGiftStatus.initial,
    this.items = const [],
    this.item,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  GiftingsState copyWith(
      {GiftingsPageStatus? giftingsPageStatus,
      GiftingsPageStatus? giftPageStatus,
      CreateGiftStatus? createGiftStatus,
      List<Gift>? items,
      Gift? item,
      String? errorMessage,
      bool? hasReachedMax}) {
    return GiftingsState(
      giftingsPageStatus: giftingsPageStatus ?? this.giftingsPageStatus,
      giftPageStatus: giftPageStatus ?? this.giftPageStatus,
      createGiftStatus: createGiftStatus ?? this.createGiftStatus,
      items: items ?? this.items,
      item: item ?? this.item,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        giftingsPageStatus,
        giftPageStatus,
        createGiftStatus,
        items,
        item,
        errorMessage,
        hasReachedMax
      ];
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
  submitting,
  submitted,
  submissionError,
  submissionInitial
}

enum CreateGiftStatus {
  initial,
  creationSuccess,
  creationError,
}
