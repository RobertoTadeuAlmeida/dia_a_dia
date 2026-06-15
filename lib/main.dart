import 'package:dia_a_dia/modules/login/repositories/auth_repository.dart';
import 'package:dia_a_dia/modules/login/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';
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
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFEEF0F8),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B4FE8)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
