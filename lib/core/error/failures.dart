import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message, List<Object> attributes = const []})
      : super();

  @override
  List<Object> get props => [message];
}

//General Failures
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({required super.message});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class GenericOperationFailure extends Failure {
  const GenericOperationFailure({required super.message});
}
