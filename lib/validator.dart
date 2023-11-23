class Validator {
  static String? validateEmail(String value) {
    late String _msg;
    RegExp regexp = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      _msg = 'Your username is required';
    } else if (!regexp.hasMatch(value)) {
      _msg = 'Please provide a valid email address';
    }
    return _msg;
  }
}

class EmailValidator {
  static String? validate(String? value) {
    RegExp regexp = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return value == null || value.isEmpty ? "Email can't be empty" : null;
  }
}
