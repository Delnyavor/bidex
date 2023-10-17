import 'package:bidex/features/auth/data/datasources/local_data_source_impl.dart';
import 'package:bidex/features/auth/data/models/email.dart';
import 'package:bidex/features/auth/data/models/image.dart';
import 'package:bidex/features/auth/data/models/name.dart';
import 'package:bidex/features/auth/data/models/password.dart';
import 'package:bidex/features/auth/data/models/phone.dart';
import 'package:bidex/features/auth/data/models/username.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/usecases/create_user.dart';
import 'package:bidex/features/auth/domain/usecases/logout.dart';
import 'package:bidex/features/auth/domain/usecases/get_user.dart';
import 'package:bidex/features/auth/domain/usecases/update_user.dart';
import 'package:bidex/features/auth/domain/usecases/verify_user.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser createUser;
  final GetUser getUser;
  final Logout logout;
  final UpdateUser updateUser;
  final Verify verify;

  AuthBloc({
    required this.createUser,
    required this.getUser,
    required this.logout,
    required this.updateUser,
    required this.verify,
  }) : super(const AuthState()) {
    // on<CreateUserEvent>(onCreateUserEvent);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<ImageChanged>(_onImageChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<RegisterUser>(_onRegister);
    on<SubmitUserDetails>(_onSubmitUserDetails);
    on<PageChanged>(_onPageChanged);
    on<GetLoggedUser>(_onGetLoggedUser);
    on<VerifyEvent>(_verify);
  }

  void _verify(VerifyEvent event, Emitter<AuthState> emit) async {
    emit(
        state.copyWith(verificationPageStatus: VerificationPageStatus.loading));
    final result = await verify(event.password);

    result!.fold((l) {
      emit(state.copyWith(
          verificationPageStatus: VerificationPageStatus.failed));
    }, (r) {
      emit(state.copyWith(
          hasBeenVerified: true,
          verificationPageStatus: VerificationPageStatus.successful));
    });
  }

  void _onEmailChanged(EmailChanged event, emit) {
    final email = Email.dirty(event.email);

    emit(state.copyWith(
      email: email,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, emit) {
    if (event.password == event.confirmPassword) {
      final password = Password.dirty(event.password);
      final confirmPassword = Password.dirty(event.confirmPassword);

      emit(state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
      ));
    }
  }

  void _onFirstNameChanged(FirstNameChanged event, emit) {
    final firstName = Name.dirty(event.firstName);

    emit(state.copyWith(
      firstName: firstName,
    ));
  }

  void _onLastNameChanged(LastNameChanged event, emit) {
    final lastName = Name.dirty(event.lastName);

    emit(state.copyWith(
      lastName: lastName,
    ));
  }

  void _onUsernameChanged(UsernameChanged event, emit) {
    final username = Username.dirty(event.username);

    emit(state.copyWith(
      username: username,
    ));
  }

  void _onImageChanged(ImageChanged event, emit) {
    final image = Image.dirty(event.imagePath);

    emit(state.copyWith(
      image: image,
    ));
  }

  void _onPhoneChanged(PhoneChanged event, emit) {
    final phone = Phone.dirty(event.phonePath);

    emit(state.copyWith(
      phone: phone,
    ));
  }

  void _onPageChanged(PageChanged event, emit) {
    emit(state.copyWith(page: event.page, shouldChangePage: event.update));
  }

  // -----------REGISTER USER-----------------
  Future<void> _onRegister(
    RegisterUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(pageStatus: RegistrationPageStatus.loading));

    final result = await createUser(state.email.value, state.password.value);

    result!.fold(
      (failure) => emit(state.copyWith(
        pageStatus: RegistrationPageStatus.failed,
        error: failure.message,
      )),
      ((user) => emit(state.copyWith(
            pageStatus: RegistrationPageStatus.successful,
          ))),
    );

    emit(state.copyWith(pageStatus: RegistrationPageStatus.none));
  }

  // ------------MODIFY USER----------------------

  Future<void> _onSubmitUserDetails(
      SubmitUserDetails event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
        registrationUserDetailsPageStatus:
            RegistrationUserDetailsPageStatus.loading));

    final user = await populateUserFields();
    final result = await updateUser(user!);
    result!.fold(
      (failure) => emit(state.copyWith(
        registrationUserDetailsPageStatus:
            RegistrationUserDetailsPageStatus.failed,
        error: failure.message,
      )),
      ((user) => emit(state.copyWith(
            registrationUserDetailsPageStatus:
                RegistrationUserDetailsPageStatus.successful,
          ))),
    );
  }

  Future<UserModel?> populateUserFields() async {
    User currentUser = await LocalAuthSourceImpl().getUser();

    return UserModel(
      id: currentUser.id,
      photo: '',
      firstName: state.firstName.value,
      lastName: state.lastName.value,
      username: state.username.value,
      phone: state.phone.value,
      email: currentUser.email,
      idToken: currentUser.idToken,
      refreshToken: currentUser.refreshToken,
    );
  }

  Future<void> _onGetLoggedUser(
      GetLoggedUser event, Emitter<AuthState> emit) async {
    User currentUser = await LocalAuthSourceImpl().getUser();
    emit(state.copyWith(user: currentUser));
  }
}
