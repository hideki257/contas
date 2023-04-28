import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_check_cont.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AuthCheckWidget extends ConsumerWidget {
  const AuthCheckWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCheckCont = ref.watch(authCheckContProvider);
    return authCheckCont.isAuthenticated ? const HomePage() : const LoginPage();
  }
}
