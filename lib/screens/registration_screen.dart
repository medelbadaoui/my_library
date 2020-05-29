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
            Image.network(
              'https://www.rd.com/wp-content/uploads/2017/10/This-Is-How-Long-It-Takes-To-Read-The-Whole-Dictionary_509582812-Billion-Photos_FB-e1574101045824.jpg',
              height: 120,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
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
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Full Name')),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Number Phone')),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Email')),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      obscureText: true,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Password')),
                  SizedBox(
                    height: 20.0,
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
          ],
        ),
      ),
    );
  }
}
