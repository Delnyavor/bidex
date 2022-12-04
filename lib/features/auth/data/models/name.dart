import 'package:bidex/core/utils/validators.dart';
import 'package:formz/formz.dart';

enum NameValidationError { empty, formatError }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    FormValidators v = FormValidators();
    if (value.isEmpty) return NameValidationError.empty;
    if (!v.isAlphabetical(value)) return NameValidationError.formatError;
    return null;
  }

  String? validationToString(NameValidationError? error) {
    if (error == NameValidationError.empty) return 'value should not be empty';
    if (error == NameValidationError.formatError) {
      return 'field should only contain alphabets';
    }
    return null;
  }
}
