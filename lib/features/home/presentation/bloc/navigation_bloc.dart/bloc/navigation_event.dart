part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends NavigationEvent {
  const PageChanged({
    required this.page,
    this.shouldDisplayPrimary = true,
  });

  final int page;
  final bool shouldDisplayPrimary;

  @override
  List<Object> get props => [page, shouldDisplayPrimary];
}
