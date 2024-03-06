import 'package:bidex/features/comments/domain/entities/comment.dart';
import 'package:bidex/features/comments/domain/usecases/add_comment.dart';
import 'package:bidex/features/comments/domain/usecases/add_reply.dart';
import 'package:bidex/features/comments/domain/usecases/get_comments.dart';
import 'package:bidex/features/comments/domain/usecases/get_replies.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetComments getComments;
  final AddComment addComment;
  final AddReply addReply;
  final GetReplies getReplies;

  CommentBloc(
      {required this.getComments,
      required this.addComment,
      required this.addReply,
      required this.getReplies})
      : super(const CommentState()) {
    on<InitialiseComments>(_onInitialise);
    on<CreateComment>(_onCreateComment);
    on<FetchComments>(_onFetchComments);
    on<FetchReplies>(_onFetchReplies);
  }
  void _onInitialise(InitialiseComments event, Emitter<CommentState> emit) {
    emit(state.copyWith(
      comments: [],
      commentsStatus: CommentsStatus.initial,
      highlightedComment: null,
      errorMessage: null,
    ));
  }

  void _onFetchComments(FetchComments event, Emitter<CommentState> emit) async {
    final result = await getComments(id: event.postId);

    result!.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        commentsStatus: state.comments.isEmpty
            ? CommentsStatus.error
            : CommentsStatus.loadedError,
      ));
    }, (r) {
      late CommentsStatus status;

      if (r.isNotEmpty) {
        status = CommentsStatus.loaded;
      } else {
        if (state.comments.isEmpty) {
          status = CommentsStatus.empty;
        }
      }
      emit(
        state.copyWith(comments: r.reversed.toList(), commentsStatus: status),
      );
    });
  }

  void _onFetchReplies(FetchReplies event, Emitter<CommentState> emit) async {
    final result =
        await getReplies(postId: event.postId, commentId: event.commentId);

    result!.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        commentsStatus: state.comments.isEmpty
            ? CommentsStatus.error
            : CommentsStatus.loadedError,
      ));

      emit(state.copyWith(commentsStatus: CommentsStatus.loaded));
    }, (r) {
      int position =
          state.comments.indexWhere((element) => element.id == event.commentId);

      state.comments.insertAll(position, r);
      state.comments.addAll(r);
      emit(
        state.copyWith(
          comments: state.comments,
        ),
      );
    });
  }

  void _onCreateComment(CreateComment event, Emitter<CommentState> emit) async {
    state.comments.insert(0, event.comment);
    emit(state.copyWith(commentsStatus: CommentsStatus.loading));

    final result = await addComment(comment: event.comment);

    result!.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        commentsStatus: CommentsStatus.loadedError,
      ));
    }, (r) {
      state.comments.removeAt(0);
      state.comments.insert(0, r);
      emit(
        state.copyWith(
            comments: state.comments, commentsStatus: CommentsStatus.loaded),
      );
    });
  }
}
