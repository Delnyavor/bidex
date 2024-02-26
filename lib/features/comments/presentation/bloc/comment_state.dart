part of 'comment_bloc.dart';

class CommentState extends Equatable {
  final CommentsStatus commentsStatus;
  final List<Comment> comments;
  final Comment? highlightedComment;
  final String errorMessage;
  final bool hasReachedMax;

  const CommentState({
    this.commentsStatus = CommentsStatus.loading,
    this.comments = const [],
    this.highlightedComment,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  CommentState copyWith(
      {CommentsStatus? commentsStatus,
      List<Comment>? comments,
      Comment? highlightedComment,
      String? errorMessage,
      bool? hasReachedMax}) {
    return CommentState(
      commentsStatus: commentsStatus ?? this.commentsStatus,
      comments: comments ?? this.comments,
      highlightedComment: highlightedComment ?? this.highlightedComment,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        commentsStatus,
        comments,
        highlightedComment,
        errorMessage,
        hasReachedMax
      ];
}

enum CommentsStatus {
  loading,
  loaded,
  empty,
  error,
  loadedError,
  initial,
}
