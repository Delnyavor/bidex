part of 'giftings_bloc.dart';

class GiftingsState extends Equatable {
  final GiftingsPageStatus giftingsPageStatus;
  final GiftingsPageStatus giftPageStatus;
  final CreateGiftStatus createGiftStatus;
  final List<Gift> items;
  final Gift? result;
  final String errorMessage;
  final bool hasReachedMax;

  const GiftingsState({
    this.giftingsPageStatus = GiftingsPageStatus.loading,
    this.giftPageStatus = GiftingsPageStatus.loading,
    this.createGiftStatus = CreateGiftStatus.initial,
    this.items = const [],
    this.result,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  GiftingsState copyWith(
      {GiftingsPageStatus? giftingsPageStatus,
      GiftingsPageStatus? giftPageStatus,
      CreateGiftStatus? createGiftStatus,
      List<Gift>? items,
      Gift? result,
      String? errorMessage,
      bool? hasReachedMax}) {
    return GiftingsState(
      giftingsPageStatus: giftingsPageStatus ?? this.giftingsPageStatus,
      giftPageStatus: giftPageStatus ?? this.giftPageStatus,
      createGiftStatus: createGiftStatus ?? this.createGiftStatus,
      items: items ?? this.items,
      result: result ?? this.result,
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
        result,
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
}

enum GiftPageStatus {
  giftLoading,
  giftLoaded,
  giftEmpty,
  giftError,
}

enum CreateGiftStatus {
  initial,
  loading,
  creationSuccess,
  creationError,
}
