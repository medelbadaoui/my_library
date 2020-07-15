import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/components/book.dart';
import 'package:mylibrary/components/categorie_listtile.dart';
import 'package:mylibrary/components/row_books.dart';
import 'package:mylibrary/screens/favorites_screen.dart';
import 'package:mylibrary/screens/friends_screen.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/profile_screen.dart';
import 'package:mylibrary/screens/readlater_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

import '../constants.dart';

class BooksScreen extends StatefulWidget {
  static const id = 'books_screen';
  static String pagecategorie = 'Computers';
  static int ind = 0;
  static int categorieindex = 0;
  static ScrollController scrollController;
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  LibraryModel libraryModel = LibraryModel();
  String key = '';

  ScrollPosition scrollPosition;
  bool isLoading;
  var keys = [];

  void initkeys() async {
    setState(() {
      isLoading = true;
    });
    var tab = await libraryModel.getCategories('');
    setState(() {
      keys = tab.keys.toList();
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    BooksScreen.scrollController = ScrollController(initialScrollOffset: 160.0);
    initkeys();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BooksScreen.categorieindex = 0;
    BooksScreen.pagecategorie = 'Computers';
    BooksScreen.scrollController.dispose();
    super.dispose();
  }

  void movescroller() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //write or call your logic
      //code will run when widget rendering complete
      BooksScreen.scrollController.animateTo(
          (BooksScreen.categorieindex * 160.0),
          duration: Duration(seconds: 2),
          curve: Curves.ease);
    });
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
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                  FutureBuilder(
                    future: libraryModel.getCategories(''),
                    builder: (context, snapshot) {
                      Map data = snapshot.data;
                      if (snapshot.hasError) return CircularProgressIndicator();
                      if (snapshot.hasData) {
                        movescroller();
                        return Container(
                            margin: EdgeInsets.only(left: 20),
                            height: 130,
                            child: ListView.builder(
                              controller: BooksScreen.scrollController,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index1) {
                                return CategorieListTile(
                                  name: keys[index1],
                                  selected: (keys[index1] ==
                                          BooksScreen.pagecategorie)
                                      ? true
                                      : false,
                                  onClick: () {
                                    setState(() {
                                      BooksScreen.ind = 0;
                                      BooksScreen.pagecategorie = keys[index1];
                                      BooksScreen.categorieindex = index1;
                                    });
                                  },
                                );
                              },
                              itemCount: data.length,
                            ));
                      }
                      return SizedBox();
                    },
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
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 0),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              width: double.infinity,
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
                          FutureBuilder(
                            future: libraryModel.getBooksByCategorie(
                                BooksScreen.pagecategorie, key),
                            builder: (context, snapshot) {
                              Map data = snapshot.data;
                              BooksScreen.ind = 0;
                              if (snapshot.hasError)
                                return CircularProgressIndicator();
                              if (snapshot.hasData) {
                                return Expanded(
                                    flex: 9,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        BooksScreen.ind = BooksScreen.ind + 3;
                                        if ((BooksScreen.ind - 1) <
                                            data['docs'].length) {
                                          return RowBooks(
                                              bookimage1: data['docs']
                                                      [BooksScreen.ind - 3]
                                                  ['image'],
                                              bookid1: data['docs']
                                                  [BooksScreen.ind - 3]['_id'],
                                              bookimage2: data['docs']
                                                      [BooksScreen.ind - 2]
                                                  ['image'],
                                              bookid2: data['docs']
                                                  [BooksScreen.ind - 2]['_id'],
                                              bookimage3: data['docs']
                                                      [BooksScreen.ind - 1]
                                                  ['image'],
                                              bookid3: data['docs']
                                                  [BooksScreen.ind - 1]['_id']);
                                        } else if ((BooksScreen.ind - 2) <
                                            data['docs'].length) {
                                          return RowBooks(
                                            bookimage1: data['docs']
                                                [BooksScreen.ind - 3]['image'],
                                            bookid1: data['docs']
                                                [BooksScreen.ind - 3]['_id'],
                                            bookimage2: data['docs']
                                                [BooksScreen.ind - 2]['image'],
                                            bookid2: data['docs']
                                                [BooksScreen.ind - 2]['_id'],
                                          );
                                        } else if ((BooksScreen.ind - 3) <
                                            data['docs'].length) {
                                          return RowBooks(
                                            bookimage1: data['docs']
                                                [BooksScreen.ind - 3]['image'],
                                            bookid1: data['docs']
                                                [BooksScreen.ind - 3]['_id'],
                                          );
                                        }
                                        return SizedBox(
                                          height: 1,
                                        );
                                      },
                                      itemCount:
                                          (data['docs'].length + 1 / 3).round(),
                                    ));
                              }
                              return CircularProgressIndicator();
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
