part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ChatPageStatus chatPageStatus;
  final List<Chat> items;
  final Chat? item;
  final String errorMessage;
  final bool hasReachedMax;

  const ChatState({
    this.chatPageStatus = ChatPageStatus.loading,
    this.items = const [],
    this.item,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  ChatState copyWith(
      {ChatPageStatus? chatPageStatus,
      List<Chat>? items,
      Chat? item,
      String? errorMessage,
      bool? hasReachedMax}) {
    return ChatState(
      chatPageStatus: chatPageStatus ?? this.chatPageStatus,
      items: items ?? this.items,
      item: item ?? this.item,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props =>
      [chatPageStatus, items, item, errorMessage, hasReachedMax];
}

enum ChatPageStatus {
  loading,
  loaded,
  empty,
  error,
  initialError,
  auctionLoading,
  auctionLoaded,
  auctionEmpty,
  auctionError,
}
