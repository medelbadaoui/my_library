import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/screens/registration_screen.dart';
import 'home_screen.dart';
import '../components/custom_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _auth = FirebaseAuth.instance;

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
                      Text('LOG ',
                          style: GoogleFonts.redHatText(
                              textStyle: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ))),
                      BorderedText(
                        strokeWidth: 2,
                        child: Text('IN',
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
                    height: 40.0,
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
                    btnText: 'LOGIN',
                    btnColor: Colors.black,
                    onClick: () {
                      Navigator.pushNamed(context, HomeScreen.id);
                    },
                  ),
                  Text(
                    'Forget password ?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.redHatDisplay(
                        textStyle: TextStyle(fontSize: 18), color: Colors.grey),
                  ),
                  CustomButton(
                    textColor: Colors.white,
                    btnText: 'CREATE ACCOUNT',
                    btnColor: Colors.black,
                    onClick: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
