import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/login_screen.dart';
import 'package:mylibrary/screens/profile_screen.dart';
import 'package:mylibrary/services/librarydata.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mylibrary/validators/input_validator.dart';

import '../constants.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = 'editprofile_screen';
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  LibraryModel libraryModel = LibraryModel();
  InputValidtor inputValidtor = InputValidtor();
  var temp;

  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  bool showErrorFirstName;
  bool showErrorLastName;
  bool showErrorEmail;
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(),
              title: new Text("Error"),
              content: new Text("Can't edit , check your entered data !"),
              actions: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  child: Text('Okay'),
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void reinitializevalues() {
    fnController.text = HomeScreen.userInfos['name']['first'];
    lnController.text = HomeScreen.userInfos['name']['last'];
    emailController.text = HomeScreen.userInfos['email'];
    phoneController.text = HomeScreen.userInfos['mobile'];

    var parsedDate = DateTime.parse(HomeScreen.userInfos['dob']['date']);

    dayController.text = parsedDate.day.toString();
    monthController.text = parsedDate.month.toString();
    yearController.text = parsedDate.year.toString();

    setState(() {
      showErrorLastName = false;
      showErrorEmail = false;
      showErrorFirstName = false;
    });
  }

  bool checkallinputs() {
    return (!showErrorEmail && !showErrorFirstName && !showErrorLastName);
  }

  void applychanges() {
    int day = int.parse(dayController.text);
    int month = int.parse(monthController.text);
    int year = int.parse(yearController.text);
    temp['name']['first'] = fnController.text;
    temp['name']['last'] = lnController.text;
    temp['email'] = emailController.text;
    temp['mobile'] = phoneController.text;
    DateTime birthday = DateTime(year, month, day);
    temp['dob']['date'] = birthday.toIso8601String();

    DateTime today = DateTime.now();
    if (today.month < month)
      temp['dob']['age'] = (today.year - year) - 1;
    else
      temp['dob']['age'] = (today.year - year);
  }

  @override
  void initState() {
    // TODO: implement initState
    showErrorFirstName = false;
    showErrorLastName = false;
    showErrorEmail = false;
    temp = HomeScreen.userInfos;
    reinitializevalues();

    // var parsedDate = DateTime.parse('1974-03-20 00:00:00.000');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(
          username: HomeScreen.username,
          profilepicture: HomeScreen.profilepic,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'images/back.png',
                      width: 50,
                      height: 90,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(0, 0),
                        blurRadius: 0.1,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: <Widget>[
                              EditItem(
                                  controller: fnController,
                                  title: 'First Name',
                                  textType: TextInputType.text,
                                  length: 20,
                                  showError: showErrorFirstName,
                                  onChange: (value) {
                                    setState(() {
                                      showErrorFirstName =
                                          !inputValidtor.isName(value);
                                    });
                                  },
                                  onFinish: () {
                                    fnController.text =
                                        fnController.text.trim();
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              EditItem(
                                  controller: lnController,
                                  title: 'Last Name',
                                  textType: TextInputType.text,
                                  length: 20,
                                  showError: showErrorLastName,
                                  onChange: (value) {
                                    setState(() {
                                      showErrorLastName =
                                          !inputValidtor.isName(value);
                                    });
                                  },
                                  onFinish: () {
                                    lnController.text =
                                        lnController.text.trim();
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              EditItem(
                                controller: emailController,
                                width: 270,
                                title: 'Email',
                                textType: TextInputType.emailAddress,
                                showError: showErrorEmail,
                                onChange: (value) {
                                  setState(() {
                                    showErrorEmail =
                                        !inputValidtor.isEmail(value);
                                  });
                                },
                                onFinish: () {
                                  emailController.text =
                                      emailController.text.trim();
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              EditItem(
                                  controller: phoneController,
                                  title: 'Phone',
                                  textType: TextInputType.phone,
                                  length: 10,
                                  showError: false,
                                  onFinish: () {
                                    phoneController.text =
                                        phoneController.text.trim();
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              EditBirthItem(
                                  dayController: dayController,
                                  monthController: monthController,
                                  yearController: yearController),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    ButtonProfile(
                                      color: Colors.green,
                                      icon: Icons.done,
                                      title: 'apply changes',
                                      onClick: () async {
                                        setState(() {
                                          applychanges();
                                          showErrorEmail = !inputValidtor
                                              .isEmail(emailController.text);
                                          showErrorFirstName = !inputValidtor
                                              .isName(fnController.text);
                                          showErrorLastName = !inputValidtor
                                              .isName(lnController.text);
                                        });
                                        if (checkallinputs()) {
                                          await libraryModel.editUser(
                                              HomeScreen.userid, temp);
                                          ProfileScreen.friendInfos =
                                              await libraryModel
                                                  .getUser(HomeScreen.userid);
                                        } else {
                                          _showMaterialDialog();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ButtonProfile(
                                      color: Colors.grey,
                                      icon: Icons.undo,
                                      title: 'reset values',
                                      onClick: () {
                                        setState(() {
                                          reinitializevalues();
                                        });
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonProfile extends StatelessWidget {
  ButtonProfile({this.color, this.icon, this.title, this.onClick});
  final Color color;
  final IconData icon;
  final String title;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.white,
          ),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(0, 0),
              blurRadius: 0.1,
              spreadRadius: 0.0,
            ),
          ],
        ),
        width: 140,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  EditItem(
      {@required this.controller,
      @required this.title,
      this.width,
      this.textType,
      this.length,
      this.showError,
      this.onChange,
      this.onFinish});

  final TextEditingController controller;
  final double width;
  final String title;
  final TextInputType textType;
  final int length;
  final bool showError;
  final Function onChange;
  final Function onFinish;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 13),
            child: Center(
                child: Text(
              title + ' :',
              style: GoogleFonts.openSans(),
            )),
          ),
          Container(
              width: (width != null) ? width : 230,
              height: 45,
              child: TextField(
                  maxLength: length,
                  keyboardType: textType,
                  controller: controller,
                  onChanged: onChange,
                  onEditingComplete: onFinish,
                  decoration: (showError)
                      ? kTextFieldEditDecoration.copyWith(
                          errorText: '',
                          errorStyle:
                              TextStyle(fontSize: 0.1, color: Colors.red),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        )
                      : kTextFieldEditDecoration)),
        ],
      ),
    );
  }
}

class EditBirthItem extends StatelessWidget {
  EditBirthItem(
      {this.dayController, this.monthController, this.yearController});

  final dayController;
  final monthController;
  final yearController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 13),
            child: Text(
              'Birthday :',
              style: GoogleFonts.openSans(),
            ),
          ),
          Container(
            width: 70,
            height: 45,
            child: TextField(
                maxLength: 2,
                keyboardType: TextInputType.datetime,
                controller: dayController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldEditDecoration.copyWith(
                    hintText: 'Day', hintStyle: TextStyle(fontSize: 12))),
          ),
          Container(
            child: Center(child: Text('/')),
            height: 45,
          ),
          Container(
            width: 70,
            height: 45,
            child: TextField(
                maxLength: 2,
                keyboardType: TextInputType.datetime,
                controller: monthController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldEditDecoration.copyWith(
                    hintText: 'Month', hintStyle: TextStyle(fontSize: 10))),
          ),
          Container(
            child: Center(child: Text('/')),
            height: 45,
          ),
          Container(
            width: 80,
            height: 45,
            child: TextField(
                maxLength: 4,
                keyboardType: TextInputType.datetime,
                controller: yearController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldEditDecoration.copyWith(
                    hintText: 'Year', hintStyle: TextStyle(fontSize: 12))),
          ),
        ],
      ),
    );
  }
}
