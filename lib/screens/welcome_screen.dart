import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/screens/registration_screen.dart';

import '../components/custom_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  Widget logoText;
  DecorationImage backgroundimage = DecorationImage(
    alignment: Alignment.topLeft,
    image: AssetImage('images/bg_welcomepage.jpg'),
    fit: BoxFit.fill,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: backgroundimage,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Image.asset('images/logo.png'),
                    height: 150,
                  ),
                ),
                /*Text(
                  'MyLibrary',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                      fontSize: 42.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 250.0,
                ),
                CustomButton(
                  btnText: 'SIGN UP',
                  textColor: Colors.white,
                  btnColor: Colors.black,
                  onClick: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                ),
                CustomButton(
                  btnText: 'LOGIN',
                  textColor: Colors.black,
                  btnColor: Colors.white,
                  onClick: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
