import 'dart:convert';

class AuthTO {
  final String email;
  final String password;

  AuthTO(this.email, this.password);

  factory AuthTO.fromRequest(String body) {
    final map = jsonDecode(body);
    return AuthTO(map['email'], map['password']);
  }
}
