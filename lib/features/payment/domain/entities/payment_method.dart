import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String name;

  const PaymentMethod({required this.name});

  @override
  List<Object?> get props => [name];
}
