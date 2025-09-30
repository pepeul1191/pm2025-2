import 'package:biblioapp/pages/profile/profile_page.dart';

import 'pages/sign_up/sign_up_page.dart';
import 'pages/reset_password/reset_password_page.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'pages/home/home_page.dart';
import 'package:flutter/material.dart';

import 'configs/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme baseTextTheme = Typography.material2021().englishLike;
    final MaterialTheme materialTheme = MaterialTheme(baseTextTheme);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      initialRoute: '/sign-in',
      routes: {
        '/home': (context) => HomePage(),
        '/sign-in': (context) => SignInPage(),
        '/profile': (context) => ProfilePage(),
        '/sign-up': (context) => SignUpPage(),
        '/reset-password': (context) => ResetPasswordPage(),
      },
      home: SignUpPage(),
    );
  }
}
