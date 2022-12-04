import 'package:bidex/core/utils/validators.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, formatError }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    FormValidators v = FormValidators();
    if (value.isEmpty) return EmailValidationError.empty;
    if (!v.validateEmail(value)) return EmailValidationError.formatError;
    return null;
  }

  String? validationToString(EmailValidationError? error) {
    if (error == EmailValidationError.empty) return 'value should not be empty';
    if (error == EmailValidationError.formatError) return 'email is invalid';
    return null;
  }
}
