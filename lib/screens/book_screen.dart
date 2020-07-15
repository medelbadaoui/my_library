import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/components/book.dart';
import 'package:mylibrary/components/book_widget.dart';
import 'package:mylibrary/components/categorie_listtile.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

String transformlang(String str) {
  if (str == 'fr') return 'French';
  return 'English';
}

class BookScreen extends StatefulWidget {
  static const id = 'book_page';
  static String bookid;
  static String des = 'about_book';
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  LibraryModel libraryModel = LibraryModel();
  bool isLoading;
  bool isReading = false;
  bool isFavorite = false;
  bool isReadLater = false;

  Future check(String type) async {
    bool result = false;
    var data = await libraryModel.getUserBooks(type, HomeScreen.userid, '');

    for (int i = 0; i < data['docs'].length; i++) {
      if (data['docs'][i]['_id'] == BookScreen.bookid) {
        setState(() {
          result = true;
        });
      }
    }

    return result;
  }

  void initbools() async {
    setState(() {
      isLoading = true;
    });
    isFavorite = await check('favorite');
    isReading = await check('encours');
    isReadLater = await check('lireplustard');
    setState(() {
      isLoading = false;
    });
  }

  Book book;
  @override
  void initState() {
    // TODO: implement initState
    initbools();
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
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: libraryModel.getBook(BookScreen.bookid),
              builder: (context, snapshot) {
                Map data = snapshot.data;
                if (snapshot.hasError) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  String authors = data['authors']
                      .toString()
                      .replaceAll(new RegExp(r'\['), '');
                  authors = authors.replaceAll(new RegExp(r'\]'), '');
                  var val = data['Subject'];

                  return BookWidget(
                    isFavorite: isFavorite,
                    isReading: isReading,
                    isReadLater: isReadLater,
                    onTapFavorite: () async {
                      await libraryModel.addUserBook(
                          'favorite', BookScreen.bookid);

                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    onTapIsReading: () async {
                      await libraryModel.addUserBook(
                          'encours', BookScreen.bookid);

                      setState(() {});
                    },
                    onTapReadLater: () async {
                      await libraryModel.addUserBook(
                          'lireplustard', BookScreen.bookid);

                      setState(() {
                        isReadLater = !isReadLater;
                      });
                    },
                    currentbook: Book(
                        id: data['_id'],
                        categorie: val[0].toString(),
                        language: transformlang(data['langage']),
                        cover: data['image'],
                        author: authors,
                        description: data['description'],
                        pages: data['pages'].toString(),
                        rating: data['rating']['rate'].toDouble().toString(),
                        title: data['title'],
                        year: data['year'].toString()),
                  );
                }
                return SizedBox();
              }),
    );
  }
}
