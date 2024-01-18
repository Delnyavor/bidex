part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class SwitchPostTypeEvent extends CreatePostEvent {
  final PostType type;
  const SwitchPostTypeEvent({required this.type});

  @override
  List<Object> get props => [type];
}

class SubmitPost extends CreatePostEvent {}

class PostSubmitted extends CreatePostEvent {
  final bool didSucceed;
  final String error;
  const PostSubmitted({required this.didSucceed, this.error = ''});

  @override
  List<Object> get props => [didSucceed, error];
}
