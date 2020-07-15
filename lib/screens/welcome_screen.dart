import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bordered_text/bordered_text.dart';
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Image.asset(
                  'images/welcomebanner.jpg',
                  fit: BoxFit.cover,
                ),
                width: double.infinity,
                height: 200,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5, right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('WELCO',
                                  style: GoogleFonts.redHatText(
                                      textStyle: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ))),
                              BorderedText(
                                strokeWidth: 2,
                                child: Text('ME',
                                    style: GoogleFonts.redHatText(
                                        textStyle: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ))),
                              ),
                            ],
                          ),
                          Text(
                            'Read without limit unlimited books in your free time ',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.ubuntu(
                              height: 1.5,
                              textStyle: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Next ➞ ',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomButton(
                            btnText: 'SIGN UP',
                            textColor: Colors.white,
                            btnColor: Colors.black,
                            onClick: () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
