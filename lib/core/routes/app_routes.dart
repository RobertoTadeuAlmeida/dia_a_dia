import 'package:dia_a_dia/core/routes/route_names.dart';
import 'package:flutter/material.dart';

import '../../modules/home/view/home_page.dart';
import '../../modules/login/view/pages/login_page.dart';
import '../../modules/login/view/pages/signup_page.dart';

abstract final class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    RouteNames.login: (_) => const LoginPage(),
    RouteNames.signup: (_) => const SignupPage(),
    RouteNames.home: (_) => const HomePage(),
  };
}
