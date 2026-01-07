import 'package:biblioapp/pages/book/book_page.dart';
import 'package:biblioapp/pages/profile/profile_page.dart';
import 'package:biblioapp/services/session_service.dart';

import 'pages/sign_up/sign_up_page.dart';
import 'pages/reset_password/reset_password_page.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'pages/home/home_page.dart';
import 'pages/trip/trip_page.dart';
import 'package:flutter/material.dart';

import 'configs/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar SharedPreferences
  await SessionService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme baseTextTheme = Typography.material2021().englishLike;
    final MaterialTheme materialTheme = MaterialTheme(baseTextTheme);
    SessionService session = SessionService();

    print('1 +++++++++++++++++++++++++++++');
    print(session);
    print('2 +++++++++++++++++++++++++++++');
    print(session.isLoggedIn());
    print('3 +++++++++++++++++++++++++++++');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      //initialRoute: session.isLoggedIn() ? '/home' : '/sign-in',
      initialRoute: '/sign-in',
      routes: {
        '/map': (context) => TripPage(),
        '/home': (context) => HomePage(),
        '/sign-in': (context) => SignInPage(),
        '/profile': (context) => ProfilePage(),
        '/book': (context) => BookPage(),
        '/sign-up': (context) => SignUpPage(),
        '/reset-password': (context) => ResetPasswordPage(),
      },
      home: SignInPage(),
    );
  }
}
