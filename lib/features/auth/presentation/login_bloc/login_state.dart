part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginPageStatus.none,
    this.formzStatus = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.error = '',
    this.shouldValidate = false,
  });
  final LoginPageStatus status;
  final FormzStatus formzStatus;
  final Email email;
  final Password password;
  final String error;
  final bool shouldValidate;

  LoginState copyWith({
    LoginPageStatus? status,
    FormzStatus? formzStatus,
    Email? email,
    Password? password,
    String? error,
    bool? shouldValidate,
  }) {
    return LoginState(
      status: status ?? this.status,
      formzStatus: formzStatus ?? this.formzStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      shouldValidate: shouldValidate ?? this.shouldValidate,
    );
  }

  @override
  List<Object> get props =>
      [status, formzStatus, email, password, error, shouldValidate];
}

enum LoginPageStatus { loading, successful, failed, none }
