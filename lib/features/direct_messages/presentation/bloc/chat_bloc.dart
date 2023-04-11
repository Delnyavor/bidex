// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final list = [
    Chat(
        text: 'A random message showing an ongoing conversation',
        created: DateTime.now(),
        user: '0000'),
    Chat(
        text: 'A random message showing an ongoing conversation',
        created: DateTime.now(),
        user: '0001'),
    Chat(
        text: 'A random message showing an ongoing conversation',
        created: DateTime.now(),
        user: '0000'),
    Chat(
        text: 'A random message showing an ongoing conversation',
        created: DateTime.now(),
        user: '0000'),
  ];
  ChatBloc() : super(const ChatState()) {
    on<CreateChat>(_onCreateChat);
    on<FetchChats>(_onFetchChats);
  }

  void _onFetchChats(FetchChats event, Emitter<ChatState> emit) async {
    emit(
      state.copyWith(items: list),
    );
  }

  void _onCreateChat(CreateChat event, Emitter<ChatState> emit) async {
    emit(
      state.copyWith(
        items: state.items + [event.chat],
      ),
    );
  }
}
