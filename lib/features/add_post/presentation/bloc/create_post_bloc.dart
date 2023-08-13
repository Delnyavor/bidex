import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(const CreatePostState()) {
    on<SubmitPost>(onSubmitPostEvent);
    on<PostSubmitted>(onPostEventSubmitted);
    on<SwitchPostTypeEvent>(onSwitchPostTypeEvent);
    on<InitialiseCreatePost>(onInitialise);
  }

  onSwitchPostTypeEvent(
      SwitchPostTypeEvent event, Emitter<CreatePostState> emit) {
    emit(state.copyWith(page: event.page));
  }

  onSubmitPostEvent(SubmitPost event, Emitter<CreatePostState> emit) {
    print('create post bloc: submitting post');
    emit(state.copyWith(pageStatus: CreatePostPageStatus.loading));
  }

  onPostEventSubmitted(PostSubmitted event, Emitter<CreatePostState> emit) {
    print('create post bloc: post submitted');

    emit(state.copyWith(pageStatus: CreatePostPageStatus.successful));
  }

  onInitialise(InitialiseCreatePost event, Emitter<CreatePostState> emit) {
    emit(state.copyWith(pageStatus: CreatePostPageStatus.initial, page: 0));
  }
}
