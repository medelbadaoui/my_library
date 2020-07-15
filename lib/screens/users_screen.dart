import 'package:flutter/material.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/components/user_card.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/profile_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

import '../constants.dart';
import 'books_screen.dart';

class UsersScreen extends StatefulWidget {
  static const id = 'users_screen';
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  LibraryModel libraryModel = LibraryModel();
  String key = '';
  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        username: HomeScreen.username,
        profilepicture: HomeScreen.profilepic,
        selecteditem: 'Home',
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Color(0xFF2F4F3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Image.asset(
                  'images/back.png',
                  width: 50,
                  height: 90,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
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
                margin:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 300,
                        child: TextField(
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              //Do something with the user input.

                              setState(() {
                                key = value;
                              });
                            },
                            decoration: kSearchFieldDecoration.copyWith(
                                hintText: 'Search')),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: libraryModel.getUsers(key),
                      builder: (context, snapshot) {
                        Map data = snapshot.data;
                        if (snapshot.hasError)
                          return CircularProgressIndicator();
                        if (snapshot.hasData) {
                          return Expanded(
                            flex: 6,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ProfileScreen.userid =
                                            data['docs'][index]['_id'];
                                      });

                                      Navigator.pushNamed(
                                          context, ProfileScreen.id);
                                    },
                                    child: UserItem(
                                      username: data['docs'][index]['name']
                                              ['first'] +
                                          ' ' +
                                          data['docs'][index]['name']['last'],
                                      image: data['docs'][index]['picture']
                                          ['medium'],
                                    ));
                              },
                              itemCount: data['docs'].length,
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Text("No results for " + ' $key ');
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
