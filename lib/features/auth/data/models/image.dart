import 'package:formz/formz.dart';

enum ImageValidationError { empty }

class Image extends FormzInput<String, ImageValidationError> {
  const Image.dirty(super.value) : super.dirty();
  const Image.pure() : super.pure('');

  @override
  ImageValidationError? validator(String? value) {
    if (value!.isEmpty) return ImageValidationError.empty;
    return null;
  }

  String? validationToString(ImageValidationError? error) {
    if (error == ImageValidationError.empty) {
      return 'Profile picture is required';
    }

    return null;
  }
}
