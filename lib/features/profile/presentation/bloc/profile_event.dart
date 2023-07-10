part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FilterAuctions extends ProfileEvent {
  final int value;
  const FilterAuctions(this.value);
}

class FilterBarters extends ProfileEvent {
  final int value;
  const FilterBarters(this.value);
}

class FilterGifts extends ProfileEvent {
  final int value;
  const FilterGifts(this.value);
}
