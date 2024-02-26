import 'package:bidex/features/comments/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/comment.dart';

class GetComments {
  final CommentsRepository repository;

  GetComments({required this.repository});

  Future<Either<Failure, List<Comment>>?>? call({required String id}) async {
    return await repository.fetchComments(id);
  }
}
