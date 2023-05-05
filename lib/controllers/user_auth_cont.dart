import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAuthContProvider =
    ChangeNotifierProvider<UserAuthCont>((_) => UserAuthCont.get());

class UserAuthCont extends ChangeNotifier {
  static final UserAuthCont _instance = UserAuthCont._();

  static get() {
    return UserAuthCont._instance;
  }

  bool isLoading = true;
  bool isAuthenticated = false;
  User? user;

  static String get usuarioId {
    return UserAuthCont._instance.user?.uid ?? '';
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserAuthCont._() {
    _initUserAuth();
  }

  _initUserAuth() {
    _getUser();
  }

  sair() async {
    await _auth.signOut();
    _getUser();
  }

  _getUser() {
    isLoading = true;
    isAuthenticated = false;
    user = _auth.currentUser;
    if (user != null) {
      isAuthenticated = true;
    }
    isLoading = false;
    notifyListeners();
  }
}
