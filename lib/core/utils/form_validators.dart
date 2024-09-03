class AppFormValidator {
  static String? pin(String? value, int codeLength) {
    final val = '$value'.trim();

    if (val.isEmpty) return 'Required';

    if (val.length < codeLength) {
      return 'Pin must be $codeLength digit';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    final val = '$value'.trim();
    if (val.isEmpty) return 'Email is Required';

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!(regex.hasMatch(val))) return 'Please enter a valid email address';
    return null;
  }

  static String? validateField(String? value, String feild) {
    if (value?.isEmpty ?? true) {
      return '$feild is required';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value, [String? exp]) {
    final val = '$value'.trim();

    if (val.isEmpty) return 'Password is required';

    if (!RegExp(exp ?? "^(?=.*[0-9])(?=.*[A-Za-z])(?=.{8,})").hasMatch(val)) {
      return 'Minimum of 8 characters.\nMust contain at least one special text (!@#\$%_^&*)';
    }

    return null;
  }
}
