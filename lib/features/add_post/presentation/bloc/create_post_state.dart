part of 'create_post_bloc.dart';

class CreatePostState extends Equatable {
  const CreatePostState(
      {this.page = 0, this.pageStatus = CreatePostPageStatus.initial});
  final int page;
  final CreatePostPageStatus pageStatus;

  CreatePostState copyWith({int? page, CreatePostPageStatus? pageStatus}) {
    return CreatePostState(
      page: page ?? this.page,
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }

  @override
  List<Object> get props => [page, pageStatus];
}

enum CreatePostPageStatus {
  initial,
  loading,
  failed,
  successful,
}
