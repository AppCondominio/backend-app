import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../to/auth_to.dart';
import 'register_condo_service.dart';
import 'register_user_service.dart';

class LoginService {
  final RegisterCondoService _registerCondoService;
  final RegisterUserService _registerUserService;
  LoginService(this._registerCondoService, this._registerUserService);

  Future authenticate(AuthTO to) async {
    try {
      var user = await _registerUserService.findByDocument(to.document);
      var condo = await _registerCondoService.findByDocument(to.document);
      if (condo == null && user == null) {
        return null;
      } else if (condo != null && Password.verify(to.password, condo.password!)) {
        return condo;
      } else if (user != null && Password.verify(to.password, user.password!)) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      log('ERROR/DB -> Cant validate the request');
    }
    return null;
  }
}
