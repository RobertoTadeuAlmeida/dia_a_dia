import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/widgets/error_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../home/view/home_page.dart';
import '../../models/auth_status.dart';
import '../../utils/login_validators.dart';
import '../../viewmodel/auth_viewmodel.dart';
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().checkSession();
    });
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleAuthState(authViewModel);
      _handleError(authViewModel);
    });

    return Scaffold(
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
                child: LoginCard(
                  emailController: emailController,
                  passwordController: passwordController,
                  emailValidator: LoginValidators.email,
                  passwordValidator: LoginValidators.password,
                  obscurePassword: obscurePassword,
                  onTogglePassword: togglePasswordVisibility,
                  isLoading: isLoading,
                  onSignIn: _handleSignIn,
                  onGoogleSignIn: _handleGoogleSignIn,
                ),
              ),

              const SizedBox(height: 16),

              ErrorMessage(message: authViewModel.errorMessage),

              const SizedBox(height: 28),

              _SignUpText(
                onTap: () {
                  Navigator.of(context).pushNamed('/signup');
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

  void _handleError(AuthViewModel authViewModel) {
    if (!mounted) return;

    if (authViewModel.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(authViewModel.errorMessage!)));
    }
    authViewModel.clearError();
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

  Future<void> _handleGoogleSignIn() async {
    final authViewModel = context.read<AuthViewModel>();

    await authViewModel.signInWithGoogle();
  }

  void _handleAuthState(AuthViewModel authViewModel) {
    if (!mounted) return;

    if (authViewModel.status == AuthStatus.authenticated) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }
}

class _SignUpText extends StatelessWidget {
  const _SignUpText({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: AppKeys.createAccountButton,
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: 'Não tem uma conta? ',
          style: const TextStyle(color: Color(0xFF8E94A3), fontSize: 14),
          children: [
            TextSpan(
              text: 'Criar conta',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
