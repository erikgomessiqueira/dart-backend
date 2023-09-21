import 'dart:developer';

import 'package:password_dart/password_dart.dart';
import 'package:test_backend/dao/user_dao.dart';
import 'package:test_backend/services/generic_service.dart';
import 'package:test_backend/services/user_service.dart';
import 'package:test_backend/to/auth_to.dart';

class LoginService {
  final UserService _userService;

  LoginService(this._userService);
  Future<int> authenticate(AuthTO to) async {
    try {
      final user = await _userService.findByEmail(to.email);
      if (user == null) return -1;
      return Password.verify(to.password, user.password!) ? user.id! : -1;
    } catch (_) {
      log('[ERROR] -> in autenticate by email: ${to.email}');
      return -1;
    }
  }
}
