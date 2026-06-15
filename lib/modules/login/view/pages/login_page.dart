import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/auth_status.dart';
import '../../viewmodel/auth_viewmodel.dart';
import 'widgets/app_logo.dart';
import 'widgets/login_card.dart';

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final isLoading = authViewModel.status == AuthStatus.loading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 56),

              const AppLogo(),

              const SizedBox(height: 40),

              LoginCard(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
                obscurePassword: obscurePassword,
                onTogglePassword: togglePasswordVisibility,
                isLoading: isLoading,
                onSignIn: _handleSignIn,
              ),

              const SizedBox(height: 28),

              _SignUpText(
                onTap: () {
                  //TODO: navegar para cadastro.
                },
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

  Future<void> _handleSignIn() async {
    final authViewModel = context.read<AuthViewModel>();
    if (formKey.currentState!.validate()) {
      await authViewModel.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    }
  }
}

class _SignUpText extends StatelessWidget {
  const _SignUpText({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Não tem uma conta? ',
        style: const TextStyle(color: Color(0xFF8E94A3), fontSize: 14),
        children: [
          TextSpan(
            text: 'Criar conta',
            style: const TextStyle(

            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
