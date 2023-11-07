part of 'giftings_bloc.dart';

abstract class GiftingsEvent extends Equatable {
  const GiftingsEvent();

  @override
  List<Object> get props => [];
}

class FetchGiftsEvent extends GiftingsEvent {
  const FetchGiftsEvent();
}

class FetchGiftEvent extends GiftingsEvent {
  final String id;
  const FetchGiftEvent({required this.id});
}

class CreateGiftEvent extends GiftingsEvent {
  final Gift item;
  const CreateGiftEvent({required this.item});

  @override
  List<Object> get props => [item];
}

class DeleteGiftEvent extends GiftingsEvent {
  final String id;
  const DeleteGiftEvent({required this.id});
}

class UpdateGiftEvent extends GiftingsEvent {
  final Gift item;
  const UpdateGiftEvent({required this.item});
}

class InitGiftCreation extends GiftingsEvent {
  const InitGiftCreation();
}
