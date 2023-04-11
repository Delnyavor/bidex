part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginPageStatus.none,
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.error = '',
    this.shouldValidate = false,
  });
  final LoginPageStatus status;
  final FormzSubmissionStatus formzSubmissionStatus;
  final Email email;
  final Password password;
  final String error;
  final bool shouldValidate;

  LoginState copyWith({
    LoginPageStatus? status,
    FormzSubmissionStatus? formzSubmissionStatus,
    Email? email,
    Password? password,
    String? error,
    bool? shouldValidate,
  }) {
    return LoginState(
      status: status ?? this.status,
      formzSubmissionStatus:
          formzSubmissionStatus ?? this.formzSubmissionStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      shouldValidate: shouldValidate ?? this.shouldValidate,
    );
  }

  @override
  List<Object> get props =>
      [status, formzSubmissionStatus, email, password, error, shouldValidate];
}

enum LoginPageStatus { loading, successful, failed, none }
