part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({this.page = 0});

  final int page;
  NavigationState copyWith({
    int? page,
  }) {
    return NavigationState(
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [page];
}
