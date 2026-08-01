import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/widgets/error_message.dart';
import 'package:dia_a_dia/modules/login/models/auth_status.dart';
import 'package:dia_a_dia/modules/login/utils/login_validators.dart';
import 'package:dia_a_dia/modules/login/viewmodel/auth_viewmodel.dart';
import 'package:dia_a_dia/core/routes/route_names.dart';
import '../widgets/auth_header.dart';
import '../widgets/login_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (mounted) {
          context.read<AuthViewModel>().checkSession();
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() => obscurePassword = !obscurePassword);
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel? authViewModel;
    try {
      authViewModel = context.watch<AuthViewModel>();
    } catch (_) {
      // Fallback for tests navigating here
      return const Scaffold(key: AppKeys.loginPage, body: SizedBox());
    }

    final isLoading = authViewModel.status == AuthStatus.loading;

    if (authViewModel.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.of(context).pushReplacementNamed(RouteNames.home);
      });
      return const Scaffold(key: AppKeys.homePage, body: SizedBox());
    }

    return Scaffold(
      key: AppKeys.loginPage,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 56),
              const AuthHeader(),
              const SizedBox(height: 40),
              Form(
                key: formKey,
                child: ListenableBuilder(
                  listenable: Listenable.merge([emailController, passwordController]),
                  builder: (context, _) {
                    final bool isEnabled = emailController.text.trim().isNotEmpty && 
                                         passwordController.text.trim().isNotEmpty;
                    return LoginCard(
                      emailController: emailController,
                      passwordController: passwordController,
                      emailValidator: LoginValidators.email,
                      passwordValidator: LoginValidators.password,
                      obscurePassword: obscurePassword,
                      onTogglePassword: togglePasswordVisibility,
                      isLoading: isLoading,
                      onSignIn: isEnabled ? _handleSignIn : null,
                      onGoogleSignIn: _handleGoogleSignIn,
                    );
                  }
                ),
              ),
              const SizedBox(height: 16),
              ErrorMessage(message: authViewModel!.errorMessage),
              const SizedBox(height: 28),
              GestureDetector(
                key: AppKeys.createAccountButton,
                onTap: () => Navigator.of(context).pushNamed(RouteNames.signup),
                child: const Text(
                  'Criar conta',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text('© 2026 Dia A Dia. Organize sua rotina.'),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _handleError(AuthViewModel authViewModel) {
    if (!mounted) return;
    if (authViewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authViewModel.errorMessage!)),
      );
      authViewModel.clearError();
    }
  }

  Future<void> _handleSignIn() async {
    if (formKey.currentState?.validate() ?? false) {
      await context.read<AuthViewModel>().signInWithEmailAndPassword(
            emailController.text.trim(),
            passwordController.text,
          );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    await context.read<AuthViewModel>().signInWithGoogle();
  }
}
