part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends NavigationEvent {
  const PageChanged(this.page);

  final int page;

  @override
  List<Object> get props => [page];
}
