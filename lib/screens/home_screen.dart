import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/components/book_card.dart';
import 'package:mylibrary/components/categorie_card.dart';
import 'package:mylibrary/screens/books_screen.dart';
import 'package:mylibrary/screens/categories_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

import '../constants.dart';
import 'book_screen.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  static var userInfos;
  static String userid = 'f5851828-c1f1-4ff2-8e58-144448fa9969';
  static String username = 'Username';
  static String profilepic =
      'https://fertilitynetworkuk.org/wp-content/uploads/2017/01/Facebook-no-profile-picture-icon-620x389.jpg';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String deleteBrackets(String str) {
  String authors = str.replaceAll(new RegExp(r'\['), '');
  authors = authors.replaceAll(new RegExp(r'\]'), '');
  return authors;
}

class _HomeScreenState extends State<HomeScreen> {
  LibraryModel libraryModel = LibraryModel();

  bool isLoading;
  String keyword = '';
  var keys = [];
  var values = [];
  Future myfuture;

  void initkeysvalues() async {
    setState(() {
      isLoading = true;
    });
    HomeScreen.userInfos = await libraryModel.getUser(HomeScreen.userid);
    var tab = await libraryModel.getCategories('');
    HomeScreen.username = HomeScreen.userInfos['login']['username'];
    HomeScreen.profilepic = HomeScreen.userInfos['picture']['medium'];

    setState(() {
      keys = tab.keys.toList();
      values = tab.values.toList();
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initkeysvalues();
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
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                alignment: Alignment.topLeft,
                image: AssetImage('images/homebanner.jpg'),
              )),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            //Do something with the user input.
                            setState(() {});
                          },
                          decoration: kSearchFieldDecoration.copyWith(
                              hintText: 'Search anything',
                              filled: true,
                              fillColor: Colors.white)),
                    ),
                  ),
                  Container(
                      height: 400,
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: const Offset(0, 1.9),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 35, 8, 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Discover new ',
                                    style: GoogleFonts.playfairDisplay(
                                        textStyle: TextStyle(fontSize: 25)),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, BooksScreen.id);
                                    },
                                    child: Text('see all',
                                        style: GoogleFonts.ubuntu(
                                          textStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.grey),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          FutureBuilder(
                            future: libraryModel.getBooks(keyword, '0', '6'),
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Expanded(
                                    child: CircularProgressIndicator());
                              if (snapshot.hasData) {
                                Map data = snapshot.data;
                                return Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          BookScreen.bookid =
                                              data['docs'][index]['_id'];
                                          Navigator.pushNamed(
                                              context, BookScreen.id);
                                        },
                                        child: BookCard(
                                            bookid: data['docs'][index]['_id'],
                                            bookimageurl: data['docs'][index]
                                                ['image'],
                                            bookwriter: deleteBrackets(
                                                data['docs'][index]['authors']
                                                    .toString()),
                                            booktitle: data['docs'][index]
                                                ['title']),
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: int.parse(data['size']),
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
                              return Text("No results for " + '" $keyword "');
                            },
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Categories ',
                            style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(fontSize: 25)),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, CategoriesScreen.id);
                            },
                            child: Text(
                              'see all',
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: libraryModel.getCategories(''),
                    builder: (context, snapshot) {
                      Map data = snapshot.data;
                      if (snapshot.hasError) return CircularProgressIndicator();
                      if (snapshot.hasData) {
                        return Container(
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (keys.isNotEmpty && values.isNotEmpty)
                                return CategorieCard(
                                    catName: keys[index],
                                    booksNumber: values[index].toString(),
                                    onClick: () {
                                      setState(() {
                                        BooksScreen.pagecategorie = keys[index];
                                        BooksScreen.categorieindex = index;
                                      });
                                      Navigator.pushNamed(
                                          context, BooksScreen.id);
                                    });
                              return CircularProgressIndicator();
                            },
                            itemCount: data.length,
                          ),
                        );
                      }
                      return SizedBox(
                        height: 1,
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
