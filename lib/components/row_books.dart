import 'package:flutter/material.dart';
import 'package:mylibrary/screens/book_screen.dart';

import 'bookimage_card.dart';

class RowBooks extends StatelessWidget {
  RowBooks(
      {@required this.bookimage1,
      this.bookimage2,
      this.bookimage3,
      this.bookid1,
      this.bookid2,
      this.bookid3});
  final String bookimage1;
  final String bookimage2;
  final String bookimage3;
  final String bookid1;
  final String bookid2;
  final String bookid3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BookImageCard(
            image: bookimage1,
            onClick: () {
              BookScreen.bookid = bookid1;
              Navigator.pushNamed(context, BookScreen.id);
            },
          ),
          BookImageCard(
            image: bookimage2,
            onClick: () {
              BookScreen.bookid = bookid2;
              Navigator.pushNamed(context, BookScreen.id);
            },
          ),
          BookImageCard(
            image: bookimage3,
            onClick: () {
              BookScreen.bookid = bookid3;
              Navigator.pushNamed(context, BookScreen.id);
            },
          )
        ],
      ),
    );
  }
}
