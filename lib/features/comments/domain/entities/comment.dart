import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String? createdAt;
  final String? updatedAt;
  final String? id;
  final String content;
  final String? likeCount;
  final String userId;
  final String? commentId;
  final String postId;
  final String type;

  const Comment(
      {this.createdAt,
      this.updatedAt,
      this.id,
      required this.content,
      this.likeCount,
      required this.userId,
      this.commentId,
      required this.postId,
      required this.type});

  @override
  List<Object?> get props => [
        id,
        updatedAt,
        createdAt,
        commentId,
        content,
        likeCount,
        userId,
        commentId,
        postId,
        type,
      ];

  factory Comment.fromMap(Map<String, dynamic> data) {
    return Comment(
      createdAt: data["createdAt"],
      updatedAt: data["updatedAt"],
      id: data["id"],
      content: data["content"],
      likeCount: data["like_count"],
      userId: data["userId"],
      commentId: data["commentId"],
      postId: data["postId"],
      type: data["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content};
  }
}
