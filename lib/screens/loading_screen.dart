import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mylibrary/screens/welcome_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation coloranimation;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    coloranimation =
        ColorTween(begin: Color(0xFF64D6B5), end: Color(0xFFC3CEE8))
            .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    // TODO: implement initState
    super.initState();
    initHomePage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void initHomePage() async {
    String s = await Future.delayed(Duration(seconds: 10), () => "hi");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WelcomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/logo.png',
                color: Color.fromRGBO(255, 255, 255, animation.value),
                colorBlendMode: BlendMode.modulate,
                width: 100,
              ),
              SizedBox(
                height: 20,
              ),
              ColorizeAnimatedTextKit(
                  colors: [
                    Color(0xFF8E6CA0),
                    Color(0xFFF9E4B0),
                    Color(0xFF64D6B5),
                    Color(0xFFC3CEE8),
                    Color(0xFFEE799A),
                  ],
                  textAlign: TextAlign.center,
                  isRepeatingAnimation: true,
                  totalRepeatCount: 30,
                  speed: Duration(milliseconds: 180),
                  text: ["MyLibrary"],
                  textStyle: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                      fontSize: 42.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF8E6CA0),
                    ),
                  ) // or Alignment.topLeft
                  ),
              Container(
                child: CircularProgressIndicator(
                  backgroundColor: coloranimation.value,
                ),
                margin: EdgeInsets.only(top: 300),
              )
            ],
          ),
        ));
  }
}
