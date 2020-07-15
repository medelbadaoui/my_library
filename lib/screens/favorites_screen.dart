import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/components/book_item.dart';
import 'package:mylibrary/constants.dart';
import 'package:mylibrary/screens/book_screen.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

class FavoritesScreen extends StatefulWidget {
  static const id = 'favorites_screen';
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  LibraryModel libraryModel = LibraryModel();
  String keyword = '';

  String deleteBrackets(String str) {
    String authors = str.replaceAll(new RegExp(r'\['), '');
    authors = authors.replaceAll(new RegExp(r'\]'), '');
    return authors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        username: HomeScreen.username,
        profilepicture: HomeScreen.profilepic,
        selecteditem: 'Favorites',
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
                  'images/back.png',
                  width: 50,
                  height: 90,
                ),
              ),
            ),
            Center(
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Favorites',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              )),
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
                future: libraryModel.getUserBooks(
                    'favorite', HomeScreen.userid, keyword),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    Map data = snapshot.data;
                    if (data['docs'].length != 0)
                      return Flexible(
                        flex: 4,
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return BookItem(
                                title: data['docs'][index]['title'],
                                author: deleteBrackets(
                                    data['docs'][index]['authors'].toString()),
                                categorie: data['docs'][index]['Subject'][0],
                                image: data['docs'][index]['image'],
                                onClick: () {
                                  BookScreen.bookid =
                                      data['docs'][index]['_id'];
                                  Navigator.pushNamed(context, BookScreen.id);
                                },
                              );
                            },
                            itemCount: data['docs'].length,
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
                  return Text("No results for " + '" ${keyword} "');
                }),
          ],
        ),
      ),
    );
  }
}
