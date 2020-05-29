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
  AnimationController controller;
  Animation animation;
  Animation animationlogo;
  Widget logoText;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = ColorTween(begin: Colors.black12, end: Colors.white)
        .animate(controller);
    animationlogo = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animationlogo.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          logoText = ColorizeAnimatedTextKit(
              colors: [
                Color(0xFF8E6CA0),
                Color(0xFFF9E4B0),
                Color(0xFF64D6B5),
                Color(0xFFC3CEE8),
                Color(0xFFEE799A),
              ],
              textAlign: TextAlign.center,
              isRepeatingAnimation: false,
              speed: Duration(milliseconds: 300),
              text: ["MyLibrary"],
              textStyle: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF8E6CA0),
                ),
              ) // or Alignment.topLeft
              );
        });
      }
    });
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.asset('images/logo.png'),
              height: animationlogo.value * 200,
            ),
            (logoText != null) ? logoText : SizedBox(),
            SizedBox(
              height: 48.0,
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
    );
  }
}
