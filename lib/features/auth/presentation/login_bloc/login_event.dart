part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;

  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class EmailChanged extends LoginEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class ValidationStateChanged extends LoginEvent {
  const ValidationStateChanged(this.shouldValidate);

  final bool shouldValidate;

  @override
  List<Object> get props => [shouldValidate];
}
