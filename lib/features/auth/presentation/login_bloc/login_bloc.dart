import 'package:bidex/features/auth/data/models/password.dart';
import 'package:bidex/features/auth/data/models/email.dart';
import 'package:bidex/features/auth/domain/usecases/sign_in.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignIn _signIn;

  LoginBloc({required SignIn signIn})
      : _signIn = signIn,
        super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ValidationStateChanged>(_onValidationAllowed);
    on<LoginSubmitted>(_onSubmitted);
  }
  void _onEmailChanged(
    EmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
          email: email,
          formzStatus: Formz.validate([state.password, email]),
          status: LoginPageStatus.none),
    );
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
          password: password,
          formzStatus: Formz.validate([password, state.email]),
          status: LoginPageStatus.none),
    );
  }

  void _onValidationAllowed(
      ValidationStateChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(shouldValidate: event.shouldValidate));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    //check if the validation state is true
    if (state.formzStatus.isValidated) {
      emit(state.copyWith(status: LoginPageStatus.loading));

      final result = await _signIn(event.email, event.password);

      result!.fold((failure) {
        emit(
          state.copyWith(
            status: LoginPageStatus.failed,
            formzStatus: FormzStatus.submissionFailure,
            error: failure.message,
          ),
        );
      }, ((user) {
        if (user != null) {
          emit(
            state.copyWith(
              status: LoginPageStatus.successful,
            ),
          );
        }
      }));
    } else {
      emit(state.copyWith(
          status: LoginPageStatus.failed, error: 'Invalid inputs'));
    }
  }
}
