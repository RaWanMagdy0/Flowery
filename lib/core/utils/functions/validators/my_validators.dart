class MyValidators {
  static String? validateEmail(String? value) {
    if (_isEmpty(value)) {
      return ("Email is required");
    }
    var regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regex.hasMatch(value!)) {
      return 'Invalid email address';
    }
    return null;
  }

  static bool _isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static String? validatePassword(String? value) {
    if (_isEmpty(value)) {
      return 'Password is required';
    }
    var regex = RegExp(
        r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z])(?=.*\d).*$");
    if (!regex.hasMatch(value!)) {
      return 'Must contains A-Z, a-z, @-#-&.. , 1-9';
    }
    return null;
  }
}
