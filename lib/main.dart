import 'package:flutter/material.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/loading_screen.dart';
import 'package:mylibrary/screens/login_screen.dart';
import 'package:mylibrary/screens/registration_screen.dart';
import 'package:mylibrary/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
