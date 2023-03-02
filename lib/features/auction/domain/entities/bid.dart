import 'package:equatable/equatable.dart';

class Bid extends Equatable {
  final String userID;
  final String bidId;
  final DateTime time;

  const Bid({required this.userID, required this.bidId, required this.time});

  @override
  List<Object?> get props => [userID, bidId, time];
}
