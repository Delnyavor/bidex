import 'package:bidex/features/comments/domain/entities/comment.dart';

abstract class CommentsRemoteDataSource {
  Future<List<Comment>?>? fetchComments(String id);
  Future<Comment?>? addComment(Comment comment);
  Future<List<Comment>?>? fetchReplies(String postId, String commentId);
  Future<Comment?>? addReply(Comment comment);
}
