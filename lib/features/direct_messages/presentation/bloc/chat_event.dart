part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class CreateChat extends ChatEvent {
  final Chat chat;
  const CreateChat(this.chat);

  @override
  List<Object> get props => [chat];
}

class FetchChats extends ChatEvent {
  const FetchChats();

  @override
  List<Object> get props => [];
}
