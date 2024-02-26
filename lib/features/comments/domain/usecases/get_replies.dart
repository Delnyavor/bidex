import 'package:bidex/features/comments/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/comment.dart';

class GetReplies {
  final CommentsRepository repository;

  GetReplies({required this.repository});

  Future<Either<Failure, List<Comment>>?>? call(
      {required String postId, required String commentId}) async {
    return await repository.fetchReplies(postId, commentId);
  }
}
