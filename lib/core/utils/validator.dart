class AppValidator {
  //  mailアドレスの形式で入力されているかのチェック
  static bool emailValidator(String email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    return emailValid;
  }
}
