import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:apc/presentation/pages/profile_page.dart';
import 'package:apc/presentation/screens/auth_screen.dart';
import 'package:apc/presentation/state/auth_provider.dart';
import 'package:apc/presentation/state/nav_provider.dart';
import 'package:apc/presentation/utils/page_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  @pragma('vm:entry-point')
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _startNotiCheck();
  }

  void _startNotiCheck() async {
    try {
      final notificationSettings =
          await FirebaseMessaging.instance.requestPermission(provisional: true);
      // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        FirebaseMessaging.instance.getToken().then((token) {
          print('FCM Token: $token');
        });
      }
    } catch (e) {
      print('Noti check error: $e');
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

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
        home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/splash_logo.png'),
          backgroundColor: Colors.black,
          duration: 1500,
          nextScreen: const AuthScreen(),
        ),
      ),
    );
  }
}
