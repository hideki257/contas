import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'widgets/auth_check_widget.dart';
import 'widgets/route_not_found.dart';

class MyRouter {
  static const initialPage = '/';
  static const homePage = '/homePage';
  static const loginPage = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialPage:
        return MaterialPageRoute(builder: (_) => const AuthCheckWidget());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(
            builder: (_) => RouteNotFound(routeName: settings.name));
    }
  }
}
