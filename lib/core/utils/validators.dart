class FormValidators {
  bool validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    return regex.hasMatch(value!);
  }

  bool isNumeric(String? value) {
    return (value!.contains(RegExp(r'[0-9]{1,}')));
  }

  bool isAlphanumeric(String? value) {
    return (value!.contains(RegExp(r'^([A-Za-z1-9]*)+$')));
  }

  bool isAlphabetical(String? value) {
    return (value!.contains(RegExp(r'^[a-zA-Z_.]+$')));
  }

  bool validateMinLength(String? value, int length) {
    return value!.length > length;
  }
}
