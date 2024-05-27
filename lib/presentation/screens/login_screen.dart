import 'package:apc/presentation/state/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  _login(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false)
        .login('username', 'password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Main UI
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Text(
                'Login Screen',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 2,
                    ),
                  ),
                ),
                child: const Text('Login'),
              )
            ],
          ),
          // Loading
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (authProvider.isLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
