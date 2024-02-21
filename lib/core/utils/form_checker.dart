class FormChecker {
  RegExp get _emailRegex => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp get _usernameRegex =>
      RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$");

  RegExp get _passwordRegex =>
      RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$");

  bool usernameChecker(String data) {
    final bool usernameValid = _usernameRegex.hasMatch(data);

    return usernameValid;
  }

  bool emailChecker(String data) {
    final bool emailValid = _emailRegex.hasMatch(data);

    return emailValid;
  }

  bool passwordChecker(String data) {
    final bool passwordValid = _usernameRegex.hasMatch(data);

    return passwordValid;
  }
}
