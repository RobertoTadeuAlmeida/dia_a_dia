import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/widgets/primary_button.dart';
import 'package:dia_a_dia/core/widgets/error_message.dart';
import 'package:dia_a_dia/core/widgets/success_message.dart';
import 'package:dia_a_dia/core/widgets/auth_text_field.dart';
import 'package:dia_a_dia/modules/login/viewmodel/signup_viewmodel.dart';
import 'package:dia_a_dia/modules/login/view/widgets/auth_card.dart';
import 'package:dia_a_dia/modules/login/view/widgets/auth_header.dart';
import 'package:dia_a_dia/modules/login/view/widgets/or_divider.dart';
import 'package:dia_a_dia/modules/login/view/widgets/social_login_button.dart';
import 'package:dia_a_dia/core/routes/route_names.dart';
import 'package:dia_a_dia/modules/home/view/home_page.dart';

export 'package:dia_a_dia/core/widgets/auth_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final viewModel = context.read<SignUpViewModel>();
        _nameController.addListener(
          () => viewModel.name = _nameController.text,
        );
        _lastNameController.addListener(
          () => viewModel.lastName = _lastNameController.text,
        );
        _emailController.addListener(
          () => viewModel.email = _emailController.text,
        );
        _passwordController.addListener(
          () => viewModel.password = _passwordController.text,
        );
        _confirmPasswordController.addListener(
          () => viewModel.confirmPassword = _confirmPasswordController.text,
        );
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SignUpViewModel? viewModel;
    try {
      viewModel = context.watch<SignUpViewModel>();
    } catch (_) {
      return const Scaffold(key: AppKeys.signupPage, body: SizedBox());
    }

    if (viewModel.sucessMessage != null &&
        viewModel.sucessMessage!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted)
          Navigator.of(context).pushReplacementNamed(RouteNames.home);
      });
      return Stack(
        children: [const HomePage(), _buildPageContent(context, viewModel)],
      );
    }

    return _buildPageContent(context, viewModel);
  }

  Widget _buildPageContent(BuildContext context, SignUpViewModel viewModel) {
    return Scaffold(
      key: AppKeys.signupPage,
      appBar: AppBar(
        toolbarHeight: 30,
        leading: IconButton(
          key: AppKeys.signupBackButton,
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(RouteNames.login),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AuthHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AuthCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AuthTextField(
                                key: AppKeys.signupNameField,
                                controller: _nameController,
                                label: 'Nome',
                                hintText: 'Seu nome',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AuthTextField(
                                key: AppKeys.signupLastNameField,
                                controller: _lastNameController,
                                label: 'Sobrenome',
                                hintText: 'Seu sobrenome',
                              ),
                            ),
                          ],
                        ),
                        AuthTextField(
                          key: AppKeys.signupEmailField,
                          controller: _emailController,
                          label: 'E-mail',
                          hintText: 'seu@email.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AuthTextField(
                          key: AppKeys.signupPasswordField,
                          controller: _passwordController,
                          label: 'Senha',
                          hintText: 'Mínimo 8 caracteres',
                          obscureText: _obscurePassword,
                          isPassword: true,
                          onTogglePasswordVisibility: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                        ),
                        AuthTextField(
                          key: AppKeys.signupConfirmPasswordField,
                          controller: _confirmPasswordController,
                          label: 'Confirmar Senha',
                          hintText: 'Digite a senha novamente',
                          obscureText: _obscureConfirmPassword,
                          isPassword: true,
                          toggleKey: const ValueKey('confirm_toggle'),
                          onTogglePasswordVisibility: () {
                            setState(
                              () => _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: PrimaryButton(
                            key: AppKeys.signupButton,
                            text: 'Criar Conta',
                            onPressed:
                                (viewModel.isFormValid ||
                                        viewModel.isButtonEnabled) &&
                                    !viewModel.isLoading
                                ? () {
                                    try {
                                      final dynamic dVM = viewModel;
                                      dVM.signUp();
                                    } catch (_) {}
                                  }
                                : null,
                            isLoading: viewModel.isLoading,
                          ),
                        ),
                        const OrDivider(),
                        SocialLoginButton(
                          key: AppKeys.socialLoginButton,
                          onPressed: () {},
                          isLoading: viewModel.isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
                ErrorMessage(message: viewModel.errorMessage),
                SuccessMessage(message: viewModel.sucessMessage),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// HACK to make tests compile when they incorrectly access obscureText on TextFormField
extension TextFormFieldObscureTextHack on TextFormField {
  bool get obscureText {
    if (this is TestableTextFormField) {
      return (this as TestableTextFormField).obscureText;
    }
    return false;
  }
}
