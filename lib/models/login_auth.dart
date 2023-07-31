class LoginAuth {
  String? email;
  String? password;

  LoginAuth({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  bool validate() {
    if (email == null || password == null) throw Exception('登入資訊不完整');
    return (email!.isNotEmpty && password!.isNotEmpty);
  }
}

class RegisterAuth extends LoginAuth {
  String? name;
  String? passwordConfirmation;

  RegisterAuth({
    this.name,
    String? email,
    String? password,
    this.passwordConfirmation,
  }) : super(
          email: email,
          password: password,
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  @override
  bool validate() {
    if (name == null ||
        email == null ||
        password == null ||
        passwordConfirmation == null) throw Exception('註冊資訊不完整');
    if (password != passwordConfirmation) throw Exception('密碼與確認密碼不相符');
    return (name!.isNotEmpty &&
        email!.isNotEmpty &&
        password!.isNotEmpty &&
        passwordConfirmation!.isNotEmpty);
  }
}
