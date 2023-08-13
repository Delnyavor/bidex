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

class CreateBarterEvent extends BarterEvent {
  final BarterItem item;
  const CreateBarterEvent({required this.item});
}

class DeleteBarterEvent extends BarterEvent {
  final int id;
  const DeleteBarterEvent({required this.id});
}

class UpdateBarterEvent extends BarterEvent {
  final BarterItem item;
  const UpdateBarterEvent({required this.item});
}

class InitBarterCreation extends BarterEvent {
  const InitBarterCreation();
}
