import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<PageChanged>(onPageChanged);
  }

  void onPageChanged(PageChanged event, Emitter<NavigationState> emit) {
    emit(state.copyWith(page: event.page, primary: event.shouldDisplayPrimary));
  }
}
