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
    emit(state.copyWith(pageStatus: CreatePostPageStatus.loading));
    print(state.pageStatus);
  }

  onPostEventSubmitted(PostSubmitted event, Emitter<CreatePostState> emit) {
    emit(
      state.copyWith(
        pageStatus: event.didSucceed
            ? CreatePostPageStatus.successful
            : CreatePostPageStatus.failed,
      ),
    );
    print('submitted');
  }

  onInitialise(InitialiseCreatePost event, Emitter<CreatePostState> emit) {
    emit(state.copyWith(pageStatus: CreatePostPageStatus.initial, page: 0));
  }
}
