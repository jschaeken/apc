// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  // User? _user;

  bool _isAuthenticated = true;

  bool get isAuthenticated => _isAuthenticated;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
