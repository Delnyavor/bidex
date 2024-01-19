part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.pageStatus = RegistrationPageStatus.none,
    // this.formzStatus = FormzStatus.pure,
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
    this.error = '',
    this.hasBeenVerified = false,
    this.verificationPageStatus = VerificationPageStatus.none,
    this.registrationUserDetailsPageStatus =
        RegistrationUserDetailsPageStatus.none,
    this.user,
  }) : super();
  final RegistrationPageStatus pageStatus;
  // final FormzStatus formzStatus;
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
  final bool hasBeenVerified;
  final VerificationPageStatus verificationPageStatus;
  final RegistrationUserDetailsPageStatus registrationUserDetailsPageStatus;
  final User? user;

  AuthState copyWith({
    RegistrationPageStatus? pageStatus,
    // FormzStatus? formzStatus,
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
    bool? hasBeenVerified,
    VerificationPageStatus? verificationPageStatus,
    RegistrationUserDetailsPageStatus? registrationUserDetailsPageStatus,
    User? user,
  }) {
    return AuthState(
      pageStatus: pageStatus ?? this.pageStatus,
      // formzStatus: formzStatus ?? this.formzStatus,
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
      hasBeenVerified: hasBeenVerified ?? this.hasBeenVerified,
      verificationPageStatus:
          verificationPageStatus ?? this.verificationPageStatus,
      registrationUserDetailsPageStatus: registrationUserDetailsPageStatus ??
          this.registrationUserDetailsPageStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        pageStatus,
        // formzStatus,
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
        hasBeenVerified,
        verificationPageStatus,
        registrationUserDetailsPageStatus,
        user,
      ];
}

enum RegistrationPageStatus { loading, successful, failed, none }

enum VerificationPageStatus { loading, successful, failed, none }

enum RegistrationUserDetailsPageStatus { loading, successful, failed, none }
