import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_post.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<FilterBarters>(onFilterBarterEvent);
    on<FilterAuctions>(onFilterAuctionEvent);
    on<FilterGifts>(onFilterGiftEvent);
  }

  onFilterBarterEvent(FilterBarters event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selected: event.value));
    print(state.selected);
  }

  onFilterAuctionEvent(FilterAuctions event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selected: event.value));
    print(state.selected);
  }

  onFilterGiftEvent(FilterGifts event, Emitter<ProfileState> emit) {
    emit(state.copyWith(selected: event.value));
    print(state.selected);
  }
}
