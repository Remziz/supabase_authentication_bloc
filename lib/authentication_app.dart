import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_authenticantion_bloc/app_screens/main_screen.dart';
import 'package:supabase_authenticantion_bloc/auth_screens/login_screen.dart';
import 'package:supabase_authenticantion_bloc/auth_screens/registration_screen.dart';
import 'package:supabase_authenticantion_bloc/auth_screens/splash_screen.dart';

class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Авторизация Supabase',
      initialRoute: '/splash_screen',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/splash_screen':
            return CupertinoPageRoute(builder: (_) => SplashScreen());
          case '/login_screen':
            return CupertinoPageRoute(builder: (_) => LoginScreen());
          case '/register_screen':
            return CupertinoPageRoute(builder: (_) => RegisterScreen());
          case '/main_screen':
            return CupertinoPageRoute(builder: (_) => MainScreen());
          default:
            return null;
        }
      },
    );
  }
}
