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
    this.registrationDetailsPageStatus = RegistrationDetailsPageStatus.none,
    this.registrationUserDetailsPageStatus =
        RegistrationUserDetailsPageStatus.none,
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
  final RegistrationDetailsPageStatus registrationDetailsPageStatus;
  final RegistrationUserDetailsPageStatus registrationUserDetailsPageStatus;

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
    RegistrationDetailsPageStatus? registrationDetailsPageStatus,
    RegistrationUserDetailsPageStatus? registrationUserDetailsPageStatus,
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
      registrationDetailsPageStatus:
          registrationDetailsPageStatus ?? this.registrationDetailsPageStatus,
      registrationUserDetailsPageStatus: registrationUserDetailsPageStatus ??
          this.registrationUserDetailsPageStatus,
    );
  }

  @override
  List<Object> get props => [
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
        registrationDetailsPageStatus,
        registrationUserDetailsPageStatus,
      ];
}

enum RegistrationPageStatus { loading, successful, failed, none }

enum VerificationPageStatus { loading, successful, failed, none }

enum RegistrationDetailsPageStatus { loading, successful, failed, none }

enum RegistrationUserDetailsPageStatus { loading, successful, failed, none }
