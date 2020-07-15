import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mylibrary/components/about_book.dart';
import 'package:mylibrary/components/book.dart';
import 'package:mylibrary/components/book_info_item.dart';
import 'package:mylibrary/components/categorie_listtile.dart';
import 'package:mylibrary/screens/book_screen.dart';
import 'package:mylibrary/screens/books_screen.dart';
import 'package:mylibrary/screens/reviews_screen.dart';

class BookWidget extends StatelessWidget {
  BookWidget(
      {this.currentbook,
      this.isFavorite,
      this.isReadLater,
      this.isReading,
      this.onTapIsReading,
      this.onTapReadLater,
      this.onTapFavorite});
  final Book currentbook;
  bool isFavorite = false;
  bool isReadLater = false;
  bool isReading = false;

  Function onTapFavorite;
  Function onTapReadLater;
  Function onTapIsReading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFFF2F4F3),
          alignment: Alignment.topCenter,
          padding: new EdgeInsets.only(top: 150, right: 10.0, left: 10.0),
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              BooksScreen.ind = 0;
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
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
          margin: EdgeInsets.only(top: 170, right: 10.0, left: 10),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: onTapFavorite,
                      child: Icon(
                        (isFavorite) ? Icons.star : Icons.star_border,
                        size: 50,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTapReadLater,
                      child: Icon(
                        (isReadLater) ? Icons.bookmark : Icons.bookmark_border,
                        size: 50,
                        color: Colors.lightGreen,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: Color(0xFFD8F2E6),
                      child: Text(
                        currentbook.categorie,
                        style: TextStyle(color: Colors.green),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        currentbook.author,
                        style: TextStyle(color: Colors.black45, fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 0),
                      margin: EdgeInsets.only(top: 0, bottom: 0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        currentbook.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 10),
                      margin: EdgeInsets.only(top: 0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(0, 0),
                          blurRadius: 0.1,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      children: <Widget>[
                        BookInfoItem(name: 'About Book', selected: true),
                        BookInfoItem(
                          name: "Reviews",
                          selected: false,
                          onClick: () {
                            Navigator.pushNamed(context, ReviewsScreen.id);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Color(0xFFF2F4F3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0, 0),
                            blurRadius: 0.1,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          AboutBook(
                            id: 'Rating',
                            content: currentbook.rating,
                          ),
                          AboutBook(
                            id: 'Pages',
                            content: currentbook.pages,
                          ),
                          AboutBook(
                            id: 'Language',
                            content: currentbook.language,
                          ),
                          /*AboutBook(
                              id: 'Year',
                              content: currentbook.year,
                            ),*/
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(currentbook.description)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapIsReading,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Color(0xFF10B269),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0, 0),
                            blurRadius: 0.1,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          (isReading) ? 'Continue Reading' : 'Start Reading ',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      height: 60,
                    ),
                  ),
                  SizedBox(height: 10)
                ],
              )),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Colors.white,
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  currentbook.cover,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(0, 0),
                  blurRadius: 1.1,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            height: 230,
            width: 160,
          ),
        ),
      ],
    );
  }
}
