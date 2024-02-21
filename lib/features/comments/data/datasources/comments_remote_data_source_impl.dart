import 'dart:convert';

import 'package:bidex/api/endpoints.dart';
import 'package:bidex/core/error/exceptions.dart';
import 'package:bidex/core/utils/decode.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/comments/data/datasources/comments_remote_data_source.dart';
import 'package:bidex/features/comments/domain/entities/comment.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CommentsRemoteSourceImpl extends CommentsRemoteDataSource {
  final LocalAuthSource localAuthSource;
  CommentsRemoteSourceImpl(this.localAuthSource);
  @override
  Future<Comment?>? addComment(Comment comment) async {
    var payload = jsonEncode(comment.toJson());
    debugPrint(payload);

    String authToken =
        await localAuthSource.getUser().then((value) => value.idToken);

    http.Response response = await http
        .post(Uri.parse(EndPoints.createComment(comment.postId)),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: payload)
        .timeout(const Duration(seconds: 15));

    debugPrint(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Comment.fromMap(decode(response.body));
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<List<Comment>?>? fetchComments(String id) async {
    String authToken =
        await localAuthSource.getUser().then((value) => value.idToken);

    http.Response response = await http.get(
      Uri.parse(EndPoints.createComment(id)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    ).timeout(const Duration(seconds: 15));

    debugPrint(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return compute(_parseItems, response.body);
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<Comment?>? addReply(Comment comment) async {
    var payload = jsonEncode(comment.toJson());
    debugPrint(payload);

    String authToken =
        await localAuthSource.getUser().then((value) => value.idToken);

    http.Response response = await http
        .post(Uri.parse(EndPoints.createComment(comment.postId)),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: payload)
        .timeout(const Duration(seconds: 15));

    debugPrint(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Comment.fromMap(decode(response.body));
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<List<Comment>?>? fetchReplies(String postId, String commentId) async {
    String authToken =
        await localAuthSource.getUser().then((value) => value.idToken);

    http.Response response = await http.get(
      Uri.parse(EndPoints.createReply(postId, commentId)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    ).timeout(const Duration(seconds: 15));

    debugPrint(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return compute(_parseItems, response.body);
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  List<Comment> _parseItems(String responseBody) {
    final parsed = decode(responseBody) as List;

    return parsed.map((item) => Comment.fromMap(item)).toList();
  }
}
