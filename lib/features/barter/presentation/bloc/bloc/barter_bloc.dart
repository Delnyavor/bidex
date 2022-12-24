import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'barter_event.dart';
part 'barter_state.dart';

class BarterBloc extends Bloc<BarterEvent, BarterState> {
  BarterBloc() : super(BarterInitial()) {
    on<BarterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
