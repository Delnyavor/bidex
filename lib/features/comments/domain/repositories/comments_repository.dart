import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/comments/domain/entities/comment.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Future<Either<Failure, Comment>>? addComment(Comment comment);
  Future<Either<Failure, List<Comment>>?>? fetchComments(String id);
  Future<Either<Failure, Comment>?>? addReply(Comment comment);
  Future<Either<Failure, List<Comment>>?>? fetchReplies(
      String postId, String commentId);
}
