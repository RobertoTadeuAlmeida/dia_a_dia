import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';
import 'package:dia_a_dia/modules/login/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';
import 'core/theme/app_theme.dart';
import 'modules/login/view/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );
  const secureStorage = FlutterSecureStorage();
  final supabaseClient = Supabase.instance.client;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(
            repository: AuthRepository(
              supabaseClient: supabaseClient,
              secureStorage: secureStorage,
            ),
          ),
        ),
      ],
      child: const DiaADiaApp(),
    ),
  );
}

class DiaADiaApp extends StatelessWidget {
  const DiaADiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dia A Dia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: RouteNames.login,
      routes: AppRoutes.routes,
    );
  }
}
