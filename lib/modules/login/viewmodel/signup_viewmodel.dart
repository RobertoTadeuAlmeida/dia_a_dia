import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  SignUpViewModel({required AuthRepository repository}) : _repository = repository;

  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String _lastName = '';
  String get lastName => _lastName;
  set lastName(String value) {
    _lastName = value;
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
  }

  String? _nameError;
  String? get nameError => _nameError;

  String? _lastNameError;
  String? get lastNameError => _lastNameError;

  String? _emailError;
  String? get emailError => _emailError;

  String? _passwordError;
  String? get passwordError => _passwordError;

  String? _confirmPasswordError;
  String? get confirmPasswordError => _confirmPasswordError;

  bool _isFormValid = true;
  bool get isFormValid => _isFormValid;

  void validateForm() {
    _name = _name.trim();
    _lastName = _lastName.trim();
    _email = _email.trim();

    _validateName();
    _validateLastName();
    _validateEmail();
    _validatePassword();
    _validateConfirmPassword();

    _isFormValid = _nameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;

    notifyListeners();
  }

  void _validateName() {
    if (_name.isEmpty) {
      _nameError = 'Nome obrigatório.';
    } else if (_name.length < 2) {
      _nameError = 'O nome deve possuir no mínimo 2 caracteres.';
    } else {
      _nameError = null;
    }
  }

  void _validateLastName() {
    if (_lastName.isEmpty) {
      _lastNameError = 'Sobrenome obrigatório.';
    } else if (_lastName.length < 2) {
      _lastNameError = 'O sobrenome deve possuir no mínimo 2 caracteres.';
    } else {
      _lastNameError = null;
    }
  }

  void _validateEmail() {
    if (_email.isEmpty) {
      _emailError = 'E-mail obrigatório.';
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(_email)) {
        _emailError = 'Formato de e-mail inválido.';
      } else {
        _emailError = null;
      }
    }
  }

  void _validatePassword() {
    if (_password.isEmpty) {
      _passwordError = 'Senha obrigatória.';
    } else if (_password.length < 8) {
      _passwordError = 'A senha deve possuir no mínimo 8 caracteres.';
    } else {
      _passwordError = null;
    }
  }

  void _validateConfirmPassword() {
    if (_confirmPassword.isEmpty) {
      _confirmPasswordError = 'Confirmação de senha obrigatória.';
    } else if (_passwordError == null && _confirmPassword != _password) {
      _confirmPasswordError = 'As senhas não coincidem.';
    } else {
      _confirmPasswordError = null;
    }
  }
}
