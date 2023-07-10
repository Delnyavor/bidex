part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({this.selected = -1, this.posts = const []});

  final int selected;
  final List<UserPost> posts;

  ProfileState copyWith({
    int? selected,
    List<UserPost>? posts,
  }) {
    return ProfileState(
        selected: selected ?? this.selected, posts: posts ?? this.posts);
  }

  @override
  List<Object> get props => [selected, posts];
}
