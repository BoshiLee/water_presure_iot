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
