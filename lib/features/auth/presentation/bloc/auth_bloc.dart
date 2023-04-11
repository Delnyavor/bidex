import 'dart:io';

import 'package:bidex/features/auth/data/models/email.dart';
import 'package:bidex/features/auth/data/models/image.dart';
import 'package:bidex/features/auth/data/models/name.dart';
import 'package:bidex/features/auth/data/models/password.dart';
import 'package:bidex/features/auth/data/models/phone.dart';
import 'package:bidex/features/auth/data/models/username.dart';
import 'package:bidex/features/auth/domain/entities/user_data.dart';
import 'package:bidex/features/auth/domain/usecases/create_user.dart';
import 'package:bidex/features/auth/domain/usecases/delete_user.dart';
import 'package:bidex/features/auth/domain/usecases/get_user.dart';
import 'package:bidex/features/auth/domain/usecases/update_user.dart';
import 'package:bidex/features/auth/domain/usecases/verify_user.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser createUser;
  final GetUser getUser;
  final DeleteUser deleteUser;
  final UpdateUser updateUser;
  final Verify verify;

  AuthBloc({
    required this.createUser,
    required this.getUser,
    required this.deleteUser,
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
    on<RegistrationSubmitted>(_onSubmitted);
    on<PageChanged>(_onPageChanged);
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

  Future<void> _onSubmitted(
    RegistrationSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    //check if the validation state is true
    validateFields();

    if (true) {
      // if (state.formzStatus.isValidated) {
      emit(state.copyWith(pageStatus: RegistrationPageStatus.loading));

      final UserData? userdata = await populateUserFields();

      if (userdata == null) {
        emit(state.copyWith(
            pageStatus: RegistrationPageStatus.failed,
            error: 'Kindly ensure all fields are filled correctly'));
      } else {
        final result = await createUser(userdata);

        result!.fold((failure) {
          emit(
            state.copyWith(
              pageStatus: RegistrationPageStatus.failed,
            ),
          );
        }, ((user) {
          // if (user != null) {
          emit(
            state.copyWith(pageStatus: RegistrationPageStatus.successful),
          );
          // }
        }));
      }
    } else {
      emit(state.copyWith(
          pageStatus: RegistrationPageStatus.failed,
          error: 'Kindly ensure all fields are filled correctly'));
    }
    emit(state.copyWith(pageStatus: RegistrationPageStatus.none));
  }

  void validateFields() {
    Formz.validate([
      state.email,
      state.password,
      state.firstName,
      state.lastName,
      state.username,
      state.image,
      state.phone,
    ]);
  }

  Future<UserData?> populateUserFields() async {
    if (state.image.value.isNotEmpty) {
      return UserData(
        password: state.password.value,
        displayImage: File(state.image.value),
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        username: state.username.value,
        phoneNumber: state.phone.value,
        email: state.email.value,
      );
    }
    return null;
  }
}
