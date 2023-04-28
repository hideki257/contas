import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAuthDataProvider =
    ChangeNotifierProvider<UserAuthData>((ref) => UserAuthData.get());

class UserAuthData extends ChangeNotifier {
  static final UserAuthData _instance = UserAuthData._();

  static get() {
    return UserAuthData._instance;
  }

  bool isLoading = true;
  bool isAuthenticated = false;
  User? user;

  static String? get usuarioId {
    return UserAuthData._instance.user?.uid;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserAuthData._() {
    _initAuthData();
  }

  _initAuthData() {
    _getUser();
  }

  entrarComEmailESenha(String email, String senha) async {
    await _auth.signInWithEmailAndPassword(email: email, password: senha);
    _getUser();
  }

  criarComEmailESenha(String email, String senha) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: senha);
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
