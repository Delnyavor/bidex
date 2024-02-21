import 'package:bidex/features/comments/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/comment.dart';

class AddReply {
  final CommentsRepository repository;

  AddReply({required this.repository});

  Future<Either<Failure, Comment?>?>? call({required Comment comment}) async {
    return await repository.addReply(comment);
  }
}
