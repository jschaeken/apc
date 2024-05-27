// lib/screens/auth_screen.dart
import 'package:apc/presentation/screens/login_screen.dart';
import 'package:apc/presentation/screens/main_screen.dart';
import 'package:apc/presentation/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Builder(
      builder: (context) {
        if (authProvider.isAuthenticated) {
          return const MainScreen().animate().fadeIn();
        } else {
          return const LoginScreen().animate().fadeIn();
        }
      },
    );
  }
}
