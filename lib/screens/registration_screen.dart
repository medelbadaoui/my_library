import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/components/custom_button.dart';
import 'package:mylibrary/constants.dart';

import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset(
                'images/banner.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(top: 5, right: 15, left: 15),
                child: Row(
                  children: <Widget>[
                    Text('SIGN ',
                        style: GoogleFonts.redHatText(
                            textStyle: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ))),
                    BorderedText(
                      strokeWidth: 2,
                      child: Text(' UP',
                          style: GoogleFonts.redHatText(
                              textStyle: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 5, right: 15, left: 15),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Full Name')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Number Phone')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'Email')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        obscureText: true,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password')),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomButton(
                      textColor: Colors.white,
                      btnText: 'CREATE ACCOUNT',
                      btnColor: Colors.black,
                      onClick: () {
                        Navigator.pushNamed(context, HomeScreen.id);
                      },
                    )
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
