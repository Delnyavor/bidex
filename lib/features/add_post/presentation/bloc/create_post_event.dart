part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class SwitchPostTypeEvent extends CreatePostEvent {
  final int page;
  const SwitchPostTypeEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class SubmitPost extends CreatePostEvent {
  const SubmitPost();
}

class PostSubmitted extends CreatePostEvent {
  const PostSubmitted();
}

class InitialiseCreatePost extends CreatePostEvent {
  const InitialiseCreatePost();
}
