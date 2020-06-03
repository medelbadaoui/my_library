import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylibrary/components/categorie_listtile.dart';
import 'package:mylibrary/components/row_books.dart';

import '../constants.dart';

class BooksScreen extends StatefulWidget {
  static const id = 'books_screen';
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final rowbooks = RowBooks(
      bookimage1:
          "https://images-na.ssl-images-amazon.com/images/I/810KvROWLkL.jpg",
      bookimage2: "https://m.media-amazon.com/images/I/41nPRVWfjeL.jpg",
      bookimage3:
          "https://images-na.ssl-images-amazon.com/images/I/51M7UP8rZ3L._SX331_BO1,204,203,200_.jpg");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Color(0xFF2F4F3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Image.asset(
                'images/back.png',
                width: 50,
                height: 90,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 75,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                CategorieListTile(name: 'Design', selected: true),
                CategorieListTile(name: 'Architecture', selected: false),
                CategorieListTile(name: 'Poetry', selected: false),
                CategorieListTile(name: 'Mindset', selected: false),
                CategorieListTile(name: 'Science', selected: false),
                CategorieListTile(name: 'Economy', selected: false),
              ]),
            ),
            Expanded(
              child: Container(
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
                            },
                            decoration: kSearchFieldDecoration.copyWith(
                                hintText: 'Search')),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 6,
                      child: ListView(
                        children: <Widget>[
                          rowbooks,
                          rowbooks,
                          rowbooks,
                          rowbooks,
                          rowbooks,
                          rowbooks,
                          rowbooks,
                          rowbooks
                        ],
                      ),
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
