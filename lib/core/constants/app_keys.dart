import 'package:flutter/material.dart';

abstract final class AppKeys {
  //===========================================================================
  // AuthHeader
  //===========================================================================

  static const authHeader = Key('auth_header');
  static const authLogo = Key('auth_logo');
  static const authTitle = Key('auth_title');
  static const authSubtitle = Key('auth_subtitle');

  //===========================================================================
  // Login
  //===========================================================================

  static const loginPage = Key('login_page');
  static const loginEmailField = Key('login_email_field');
  static const loginPasswordField = Key('login_password_field');
  static const loginButton = Key('login_button');
  static const googleLoginButton = Key('google_login_button');
  static const createAccountButton = Key('create_account_button');

  //===========================================================================
  // Signup
  //===========================================================================

  static const signupPage = Key('signup_page');
  static const signupNameField = Key('signup_name_field');
  static const signupLastNameField = Key('signup_last_name_field');
  static const signupEmailField = Key('signup_email_field');
  static const signupPasswordField = Key('signup_password_field');
  static const signupConfirmPasswordField = Key(
    'signup_confirm_password_field',
  );
  static const signupButton = Key('signup_button');
  static const signupBackButton = Key('signup_back_button');

  //===========================================================================
  // PrimaryButton
  //===========================================================================

  static const primaryButton = Key('primary_button');
  static const primaryButtonText = Key('primary_button_text');
  static const primaryButtonLoading = Key('primary_button_loading');

  //===========================================================================
  // AuthCard
  //===========================================================================

  static const authCard = Key('auth_card');

  //===========================================================================
  // OrDivider
  //===========================================================================

  static const orDivider = Key('or_divider');

  //===========================================================================
  // SocialLoginButton
  //===========================================================================

  static const socialLoginButton = Key('social_login_button');
  static const socialLoginGoogleIcon = Key('social_login_google_icon');
  static const socialLoginText = Key('social_login_text');
  static const socialLoginLoading = Key('social_login_loading');

  //===========================================================================
  // AuthTextField
  //===========================================================================

  static const authTextField = Key('auth_text_field');
  static const authTextFieldLabel = Key('auth_text_field_label');
  static const authTextFieldError = Key('auth_text_field_error');
  static const authTextFieldPasswordToggle = Key(
    'auth_text_field_password_toggle',
  );
  static const authTextFieldPrefixIcon = Key('auth_text_field_prefix_icon');

  //===========================================================================
  // ErrorMessage
  //===========================================================================

  static const errorMessage = Key('error_message');
  static const errorMessageIcon = Key('error_message_icon');
  static const errorMessageText = Key('error_message_text');
}
