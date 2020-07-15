import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/screens/registration_screen.dart';
import 'package:mylibrary/services/librarydata.dart';
import 'package:mylibrary/validators/input_validator.dart';
import 'home_screen.dart';
import '../components/custom_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LibraryModel libraryModel = LibraryModel();
  InputValidtor inputValidtor = InputValidtor();

  bool usernameValidated = true;
  String username = '';
  String password = '';

  TextEditingController userNameController = TextEditingController();
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(),
              title: new Text("Alert"),
              content: new Text("Username or password is incorrect"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 5, right: 15, left: 15),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                        keyboardType: TextInputType.text,
                        controller: userNameController,
                        onChanged: (value) {
                          setState(() {
                            if (inputValidtor.validateUsername(value.trim()))
                              usernameValidated = true;
                            else
                              usernameValidated = false;
                            username = value.trim();
                          });
                        },
                        decoration: (!usernameValidated)
                            ? kTextFieldDecoration.copyWith(
                                errorText: 'Please enter a valid username',
                                hintText: 'Username',
                                errorStyle: TextStyle(
                                    fontSize: 10.0, color: Colors.red),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                              )
                            : kTextFieldDecoration.copyWith(
                                hintText: 'Username')),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        obscureText: true,
                        onChanged: (value) {
                          //Do something with the user input.

                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password')),
                    CustomButton(
                      textColor: Colors.white,
                      btnText: 'LOGIN',
                      btnColor: Colors.black,
                      onClick: () async {
                        var result =
                            await libraryModel.loginUser(username, password);
                        if (result != 404) {
                          HomeScreen.userid = result['user']['_id'];
                          Navigator.pushNamed(context, HomeScreen.id);
                        } else if (result == 404) _showMaterialDialog();
                      },
                    ),
                    Text(
                      'Forget password ?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.redHatDisplay(
                          textStyle: TextStyle(fontSize: 18),
                          color: Colors.grey),
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
            ),
          ],
        ),
      ),
    );
  }
}
