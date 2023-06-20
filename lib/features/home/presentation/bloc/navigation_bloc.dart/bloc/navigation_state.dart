part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({this.page = 0, this.primary = true});

  final int page;
  final bool primary;

  NavigationState copyWith({
    int? page,
    bool? primary,
  }) {
    return NavigationState(
      page: page ?? this.page,
      primary: primary ?? this.primary,
    );
  }

  @override
  List<Object> get props => [page, primary];
}
