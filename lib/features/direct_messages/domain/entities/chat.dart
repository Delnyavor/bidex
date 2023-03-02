import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String text;
  final DateTime created;
  final String user;
  const Chat({
    required this.text,
    required this.created,
    required this.user,
  });

  @override
  List<Object?> get props => [text, created, user];
}
