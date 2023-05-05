import 'package:flutter/material.dart';

import 'controllers/user_auth_cont.dart';
import 'models/crud.dart';
import 'pages/conta_crud_page.dart';
import 'pages/conta_list_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/usuario_crud_page.dart';
import 'widgets/auth_check_widget.dart';
import 'widgets/route_not_found.dart';

class MyRouter {
  static const initialPage = '/';
  static const homePage = '/homePage';
  static const loginPage = '/login';
  static const usuarioCrud = '/usuario/crud';
  static const contaList = '/conta/lista';
  static const contaCrud = '/conta/crud';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialPage:
        return MaterialPageRoute(builder: (_) => const AuthCheckWidget());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case usuarioCrud:
        UsuarioCrudKey usuarioCrudKey = (settings.arguments is UsuarioCrudKey)
            ? (settings.arguments as UsuarioCrudKey)
            : UsuarioCrudKey(
                crud: Crud.read,
                userId: UserAuthCont.usuarioId,
              );
        return MaterialPageRoute(
            builder: (_) => UsuarioCrudPage(usuarioCrudKey: usuarioCrudKey));
      case contaList:
        return MaterialPageRoute(builder: (_) => const ContaListPage());
      case contaCrud:
        ContaCrudKey contaCrudKey = (settings.arguments as ContaCrudKey);
        return MaterialPageRoute(
            builder: (_) => ContaCrudPage(contaCrudKey: contaCrudKey));
      default:
        return MaterialPageRoute(
            builder: (_) => RouteNotFound(routeName: settings.name));
    }
  }
}
