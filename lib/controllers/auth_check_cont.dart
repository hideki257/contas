import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/user_auth_data.dart';

final authCheckContProvider = ChangeNotifierProvider<AuthCheckCont>(
    (ref) => AuthCheckCont(ref.watch(userAuthDataProvider)));

class AuthCheckCont extends ChangeNotifier {
  final UserAuthData _userAuthData;
  AuthCheckCont(this._userAuthData);

  bool get isAuthenticated => _userAuthData.isAuthenticated;
}
