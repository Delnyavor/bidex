part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ValidationStateChanged extends AuthEvent {
  const ValidationStateChanged(this.shouldValidate);

  final bool shouldValidate;

  @override
  List<Object> get props => [shouldValidate];
}

class EmailChanged extends AuthEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final String password;
  final String confirmPassword;

  const PasswordChanged(this.password, this.confirmPassword);

  @override
  List<Object> get props => [password, confirmPassword];
}

class FirstNameChanged extends AuthEvent {
  final String firstName;

  const FirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends AuthEvent {
  final String lastName;

  const LastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

class UsernameChanged extends AuthEvent {
  final String username;

  const UsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class ImageChanged extends AuthEvent {
  final String imagePath;

  const ImageChanged(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class PhoneChanged extends AuthEvent {
  final String phonePath;

  const PhoneChanged(this.phonePath);

  @override
  List<Object> get props => [phonePath];
}

class PageChanged extends AuthEvent {
  final int page;
  final bool update;
  const PageChanged(this.page, this.update);

  @override
  List<Object> get props => [page, update];
}

class RegisterUser extends AuthEvent {}

class VerifyEvent extends AuthEvent {
  final String password;
  const VerifyEvent(this.password);

  @override
  List<Object> get props => [password];
}

class SubmitUserDetails extends AuthEvent {}
