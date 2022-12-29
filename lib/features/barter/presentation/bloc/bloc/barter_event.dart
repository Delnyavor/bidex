part of 'barter_bloc.dart';

abstract class BarterEvent extends Equatable {
  const BarterEvent();

  @override
  List<Object> get props => [];
}

class FetchBarterItems extends BarterEvent {
  const FetchBarterItems();
}

class FetchBarterItem extends BarterEvent {
  final int id;
  const FetchBarterItem({required this.id});
}

class CreateBarterItem extends BarterEvent {
  final BarterItem item;
  const CreateBarterItem({required this.item});
}

class DeleteBarterItem extends BarterEvent {
  final int id;
  const DeleteBarterItem({required this.id});
}

class UpdateBarterItem extends BarterEvent {
  final BarterItem item;
  const UpdateBarterItem({required this.item});
}
