part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

class CreateComment extends CommentEvent {
  final Comment comment;
  const CreateComment(this.comment);

  @override
  List<Object> get props => [comment];
}

class FetchComments extends CommentEvent {
  final String postId;
  const FetchComments({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class FetchReplies extends CommentEvent {
  final String postId;
  final String commentId;
  const FetchReplies({required this.postId, required this.commentId});

  @override
  List<Object?> get props => [postId, commentId];
}

class HighlightComment extends CommentEvent {
  final String commentId;
  const HighlightComment({required this.commentId});

  @override
  List<Object?> get props => [commentId];
}

class InitialiseComments extends CommentEvent {}
