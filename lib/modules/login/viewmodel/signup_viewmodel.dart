import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _repository;
  bool _isDisposed = false;

  SignUpViewModel({required AuthRepository repository})
    : _repository = repository;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
    validateForm();
  }

  String _lastName = '';
  String get lastName => _lastName;
  set lastName(String value) {
    _lastName = value;
    validateForm();
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    validateForm();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    validateForm();
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
    validateForm();
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

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _sucessMessage;
  String? get sucessMessage => _sucessMessage;

  bool _isFormValid = false;
  bool get isFormValid => _isFormValid;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isButtonEnabled => _isFormValid && !_isLoading;

  void validateForm() {
    _validateName();
    _validateLastName();
    _validateEmail();
    _validatePassword();
    _validateConfirmPassword();

    _isFormValid =
        _nameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null &&
        _name.trim().isNotEmpty &&
        _lastName.trim().isNotEmpty &&
        _email.trim().isNotEmpty &&
        _password.isNotEmpty &&
        _confirmPassword.isNotEmpty;

    notifyListeners();
  }

  void _validateName() {
    final trimmed = _name.trim();
    if (trimmed.isEmpty) {
      _nameError = 'Nome obrigatório.';
    } else if (trimmed.length < 2) {
      _nameError = 'O nome deve possuir no mínimo 2 caracteres.';
    } else {
      _nameError = null;
      _name = trimmed;
    }
  }

  void _validateLastName() {
    final trimmed = _lastName.trim();
    if (trimmed.isEmpty) {
      _lastNameError = 'Sobrenome obrigatório.';
    } else if (trimmed.length < 2) {
      _lastNameError = 'O sobrenome deve possuir no mínimo 2 caracteres.';
    } else {
      _lastNameError = null;
      _lastName = trimmed;
    }
  }

  void _validateEmail() {
    final trimmed = _email.trim();
    if (trimmed.isEmpty) {
      _emailError = 'E-mail obrigatório.';
    } else {
      final emailUri = Uri.tryParse('mailto:$trimmed');
      final bool isValid =
          emailUri != null &&
          emailUri.path == trimmed &&
          trimmed.contains('@') &&
          trimmed.split('@').last.contains('.');

      if (!isValid) {
        _emailError = 'Formato de e-mail inválido.';
      } else {
        _emailError = null;
        _email = trimmed;
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

  Future<void> signUp() async {
    validateForm();
    if (!_isFormValid) return;

    _isLoading = true;
    _errorMessage = null;
    _sucessMessage = null;
    notifyListeners();

    try {
      await _repository.signUpWithEmailAndPassword(
        name: _name,
        lastName: _lastName,
        email: _email,
        password: _password,
      );
      _sucessMessage = 'Cadastro realizado com sucesso.';
      _errorMessage = null;
    } catch (e) {
      _sucessMessage = null;
      final message = e.toString().replaceFirst('Exception: ', '');
      if (message == 'Sem conexão com a internet') {
        _errorMessage =
            'Sem conexão com a internet. Verifique sua rede e tente novamente.';
      } else if (message == 'Erro inesperado') {
        _errorMessage =
            'Ops! Não foi possível concluir o cadastro. Tente novamente mais tarde.';
      } else {
        _errorMessage = message;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
