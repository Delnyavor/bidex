part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState(
      {this.pageStatus = RegistrationPageStatus.none,
      this.formzStatus = FormzStatus.pure,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.confirmPassword = const Password.pure(),
      this.firstName = const Name.pure(),
      this.lastName = const Name.pure(),
      this.username = const Username.pure(),
      this.image = const Image.pure(),
      this.phone = const Phone.pure(),
      this.shouldChangePage = false,
      this.page = 0,
      this.error = ''})
      : super();
  final RegistrationPageStatus pageStatus;
  final FormzStatus formzStatus;
  final Email email;
  final Password password;
  final Password confirmPassword;
  final Name firstName;
  final Name lastName;
  final Username username;
  final Image image;
  final Phone phone;
  final bool shouldChangePage;
  final String error;
  final int page;

  AuthState copyWith({
    RegistrationPageStatus? pageStatus,
    FormzStatus? formzStatus,
    Email? email,
    Password? password,
    Password? confirmPassword,
    Name? firstName,
    Name? lastName,
    Username? username,
    Image? image,
    Phone? phone,
    bool? shouldChangePage,
    String? error,
    int? page,
  }) {
    return AuthState(
      pageStatus: pageStatus ?? this.pageStatus,
      formzStatus: formzStatus ?? this.formzStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      shouldChangePage: shouldChangePage ?? this.shouldChangePage,
      error: error ?? this.error,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [
        pageStatus,
        formzStatus,
        email,
        password,
        confirmPassword,
        firstName,
        lastName,
        username,
        image,
        phone,
        shouldChangePage,
        error,
        page,
      ];
}

enum RegistrationPageStatus { loading, successful, failed, none }
