import 'package:bidex/core/utils/validators.dart';
import 'package:formz/formz.dart';

enum UsernameValidationError { empty, formatError }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    FormValidators v = FormValidators();
    if (value.isEmpty) return UsernameValidationError.empty;
    if (!v.isAlphanumeric(value)) return UsernameValidationError.formatError;
    return null;
  }

  String? validationToString(UsernameValidationError? error) {
    if (error == UsernameValidationError.empty) {
      return 'value should not be empty';
    }
    if (error == UsernameValidationError.formatError) {
      return 'field should not contain special characters';
    }
    return null;
  }
}
