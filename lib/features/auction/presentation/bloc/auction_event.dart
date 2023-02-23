part of 'auction_bloc.dart';

abstract class AuctionEvent extends Equatable {
  const AuctionEvent();
  @override
  List<Object> get props => [];
}

class FetchAuctionsEvent extends AuctionEvent {
  const FetchAuctionsEvent();
}

class FetchAuctionEvent extends AuctionEvent {
  final int id;
  const FetchAuctionEvent({required this.id});
}

class CreateAuctionEvent extends AuctionEvent {
  final AuctionItem item;
  const CreateAuctionEvent({required this.item});
}

class DeleteAuctionEvent extends AuctionEvent {
  final int id;
  const DeleteAuctionEvent({required this.id});
}

class UpdateAuctionEvent extends AuctionEvent {
  final AuctionItem item;
  const UpdateAuctionEvent({required this.item});
}
