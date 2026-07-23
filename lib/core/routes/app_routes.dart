import 'package:flutter/material.dart';

import '../../modules/home/view/home_page.dart';
import '../../modules/login/view/pages/login_page.dart';
import '../../modules/login/view/pages/signup_page.dart';

class AppRoutes {
  static const login = '/';
  static const signup = '/signup';
  static const home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    login: (_) => const LoginPage(),
    signup: (_) => const SignupPage(),
    home: (_) => const HomePage(),
  };
}

