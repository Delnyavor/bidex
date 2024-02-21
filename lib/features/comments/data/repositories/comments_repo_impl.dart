import 'package:bidex/core/error/exception_handler.dart';
import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/comments/data/datasources/comments_remote_data_source.dart';
import 'package:bidex/features/comments/domain/entities/comment.dart';
import 'package:bidex/features/comments/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  final CommentsRemoteDataSource dataSource;

  CommentsRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Comment?>?>? addComment(Comment comment) async {
    try {
      final result = await dataSource.addComment(comment);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Comment>?>?>? fetchComments(String id) async {
    try {
      final result = await dataSource.fetchComments(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Comment?>?>? addReply(Comment comment) async {
    try {
      final result = await dataSource.addReply(comment);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Comment>?>?>? fetchReplies(
      String postId, String commentId) async {
    try {
      final result = await dataSource.fetchReplies(postId, commentId);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }
}
