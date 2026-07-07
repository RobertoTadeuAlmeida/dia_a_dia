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

  set lastName(String value) {}
  set email(String value) {}
  set password(String value) {}
  set confirmPassword(String value) {}

  String? _nameError;
  String? get nameError => _nameError;

  bool _isFormValid = true;
  bool get isFormValid => _isFormValid;

  void validateForm() {
    _name = _name.trim();
    if (_name.isEmpty) {
      _nameError = 'Nome obrigatório.';
      _isFormValid = false;
    } else if (_name.length < 2) {
      _nameError = 'O nome deve possuir no mínimo 2 caracteres.';
      _isFormValid = false;
    } else {
      _nameError = null;
      _isFormValid = true;
    }
    notifyListeners();
  }
}
