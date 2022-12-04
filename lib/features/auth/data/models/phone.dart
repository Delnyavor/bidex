import 'package:bidex/core/utils/validators.dart';
import 'package:formz/formz.dart';

enum PhoneValidationError { empty, tooShort }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.dirty(super.value) : super.dirty();
  const Phone.pure() : super.pure('');

  @override
  PhoneValidationError? validator(String value) {
    FormValidators v = FormValidators();
    if (!v.validateMinLength(value, 9)) return PhoneValidationError.tooShort;
    return null;
  }

  String? validationToString(PhoneValidationError? error) {
    if (error == PhoneValidationError.empty) {
      return 'phone should not be empty';
    }
    if (error == PhoneValidationError.tooShort) {
      return 'character length too short';
    }
    return null;
  }
}
