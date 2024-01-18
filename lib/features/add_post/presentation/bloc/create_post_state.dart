part of 'create_post_bloc.dart';

class CreatePostState extends Equatable {
  const CreatePostState(
      {this.type = PostType.gift,
      this.pageStatus = CreatePostPageStatus.initial});
  final PostType type;
  final CreatePostPageStatus pageStatus;

  CreatePostState copyWith({PostType? type, CreatePostPageStatus? pageStatus}) {
    return CreatePostState(
      type: type ?? this.type,
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }

  @override
  List<Object> get props => [type, pageStatus];
}

enum CreatePostPageStatus {
  initial,
  loading,
  failed,
  successful,
}
