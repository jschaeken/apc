import 'package:apc/presentation/pages/profile_page.dart';
import 'package:apc/presentation/screens/auth_screen.dart';
import 'package:apc/presentation/state/auth_provider.dart';
import 'package:apc/presentation/state/nav_provider.dart';
import 'package:apc/presentation/utils/page_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => NavProvider()),
      ],
      child: MaterialApp(
        title: 'A Players Club',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF000000),
            secondary: Color(0xFFFFFFFF),
            tertiary: Color(0xFFAA6C23),
            onSurface: Color.fromARGB(255, 255, 255, 255),
            onPrimary: Color(0xFFFFFFFF),
            surface: Color(0xFF3A3A3A),
          ),
          fontFamily: 'Black Mango',
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return ApcRoute(builder: (_) => const AuthScreen());
            case '/profile':
              final id = settings.arguments as String?;
              return ApcRoute(builder: (_) => ProfilePage(id: id ?? 'self'));
            default:
              return ApcRoute(builder: (_) => const AuthScreen());
          }
        },
        routes: const {
          // '/profile': (context) => const ProfilePage(),
        },
        home: const AuthScreen(),
      ),
    );
  }
}
