import 'package:flutter/material.dart';
import 'package:mylibrary/screens/book_page.dart';

import 'bookimage_card.dart';

class RowBooks extends StatelessWidget {
  RowBooks(
      {@required this.bookimage1,
      @required this.bookimage2,
      @required this.bookimage3});
  final String bookimage1;
  final String bookimage2;
  final String bookimage3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BookImageCard(
            image: bookimage1,
            onClick: () {
              Navigator.pushNamed(context, BookPage.id);
            },
          ),
          BookImageCard(
            image: bookimage2,
            onClick: () {
              Navigator.pushNamed(context, BookPage.id);
            },
          ),
          BookImageCard(
            image: bookimage3,
            onClick: () {
              Navigator.pushNamed(context, BookPage.id);
            },
          )
        ],
      ),
    );
  }
}
