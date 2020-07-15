import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/components/friend_card.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/profile_screen.dart';
import 'package:mylibrary/screens/users_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

import '../constants.dart';

class FriendsScreen extends StatefulWidget {
  static const id = 'friends_screen';

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  LibraryModel libraryModel = LibraryModel();
  String keyword = '';
  _showMaterialDialog(String id, String name) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(),
              title: new Text("Delete"),
              content: new Text(
                  "Do you want to delete \n" + name + " from your friendlist?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Delete'),
                  onPressed: () async {
                    await libraryModel.addFriend(id);
                    setState(() {
                      keyword = '';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

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
        selecteditem: 'Friends',
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 15, top: 0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'images/cancel.png',
                  width: 50,
                  height: 90,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(left: 15, top: 0),
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pushNamed(context, UsersScreen.id);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    color: Colors.blue,
                    child: Text(
                      'Find new friends',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      size: 40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Friends',
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    //Do something with the user input.
                    setState(() {
                      keyword = value;
                    });
                  },
                  decoration:
                      kSearchFieldDecoration.copyWith(hintText: 'Search')),
            ),
            FutureBuilder(
                future: libraryModel.getFriends(HomeScreen.userid, keyword),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    Map data = snapshot.data;
                    if (data['length'] != 0)
                      return Flexible(
                        flex: 4,
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return FriendItem(
                                image: data['docs'][index]['picture']['medium'],
                                username: data['docs'][index]['name']['first'] +
                                    ' ' +
                                    data['docs'][index]['name']['last'],
                                ondeleteaction: () {
                                  var name = data['docs'][index]['name']
                                          ['first'] +
                                      ' ' +
                                      data['docs'][index]['name']['last'];
                                  var id = data['docs'][index]['_id'];
                                  _showMaterialDialog(id, name);
                                },
                                onclickaction: () {
                                  setState(() {
                                    ProfileScreen.userid =
                                        data['docs'][index]['_id'];
                                  });
                                  Navigator.pushNamed(
                                      context, ProfileScreen.id);
                                },
                              );
                            },
                            itemCount: data['length'],
                          ),
                        ),
                      );
                  }
                  if (!snapshot.hasData)
                    return Flexible(
                      flex: 4,
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  return Text("No results");
                }),
          ],
        ),
      ),
    );
  }
}
