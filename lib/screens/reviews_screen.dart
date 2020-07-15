import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylibrary/components/review_item.dart';
import 'package:mylibrary/constants.dart';
import 'package:mylibrary/screens/book_screen.dart';
import 'package:mylibrary/screens/books_screen.dart';
import 'package:mylibrary/screens/profile_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

class ReviewsScreen extends StatefulWidget {
  static const id = 'reviews_screen';
  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  LibraryModel libraryModel = LibraryModel();

  int rate;
  String tmp = '';
  TextEditingController commentController = TextEditingController();
  _showMaterialDialog(String message) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(),
              title: new Text("Alert"),
              content: new Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
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
    rate = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ListView(
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
                FutureBuilder(
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

                        return BookCardReview(
                          title: data['title'],
                          author: authors,
                          categorie: val[0],
                          image: data['image'],
                        );
                      }
                      return SizedBox();
                    }),
                FutureBuilder(
                  future: libraryModel.getBook(BookScreen.bookid + tmp),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return CircularProgressIndicator();
                    if (snapshot.hasData) {
                      Map data = snapshot.data;
                      return Container(
                        height: 250,
                        child: ListView.builder(
                          itemCount: data['rating']['ratedby'].length,
                          itemBuilder: (context, index) {
                            return ReviewItem(
                              onImageClick: () {
                                ProfileScreen.userid =
                                    data['rating']['ratedby'][index]['_id'];
                                Navigator.pushNamed(context, ProfileScreen.id);
                              },
                              image: data['rating']['ratedby'][index]['picture']
                                  ['medium'],
                              comment: data['rating']['ratedby'][index]
                                  ['comment'],
                              rate: double.parse(data['rating']['ratedby']
                                      [index]['rate']
                                  .toString()),
                              username: data['rating']['ratedby'][index]['name']
                                  ['first'],
                            );
                          },
                        ),
                      );
                    }
                    if (!snapshot.hasData)
                      return Container(
                        height: 1,
                        child: CircularProgressIndicator(),
                      );
                    return SizedBox();
                  },
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      RateInput(
                        rate: rate,
                        color: Colors.yellow[600],
                        onfirstClick: () {
                          setState(() {
                            rate = 1;
                          });
                        },
                        onsecondClick: () {
                          setState(() {
                            rate = 2;
                          });
                        },
                        onthirdClick: () {
                          setState(() {
                            rate = 3;
                          });
                        },
                        onfourthClick: () {
                          setState(() {
                            rate = 4;
                          });
                        },
                        onfifthClick: () {
                          setState(() {
                            rate = 5;
                          });
                        },
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: 43,
                                child: TextField(
                                    controller: commentController,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      //Do something with the user input.
                                      setState(() {});
                                    },
                                    decoration: kMessageTextFieldDecoration
                                        .copyWith(hintText: 'write review')),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 43,
                                child: RaisedButton(
                                  color: Colors.blueAccent,
                                  hoverColor: Colors.green,
                                  shape: CircleBorder(),
                                  onPressed: () async {
                                    if (commentController.text.trim() != '' &&
                                        commentController.text.isNotEmpty &&
                                        rate != 0) {
                                      await libraryModel.addReview(
                                          commentController.text, rate);
                                      setState(() {
                                        tmp = '';
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      commentController.text = '';
                                    } else {
                                      if (rate == 0) {
                                        _showMaterialDialog(
                                            'Please choose the stars ');
                                      }
                                      if (commentController.text.trim() == '') {
                                        _showMaterialDialog(
                                            'Please write a comment');
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookCardReview extends StatelessWidget {
  BookCardReview({this.title, this.author, this.categorie, this.image});
  final String title;
  final String author;
  final String categorie;
  final String image;

  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              offset: const Offset(0, 0),
              blurRadius: 0.1,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.white,
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(image),
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
              height: 130,
              width: 100,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        author,
                        style: TextStyle(color: Colors.black45, fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 0),
                      margin: EdgeInsets.only(top: 0, bottom: 0),
                    ),
                    Container(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 10),
                      margin: EdgeInsets.only(top: 0),
                    ),
                    Container(
                      color: Color(0xFFD8F2E6),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text(
                        categorie,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    ),
                  ],
                ),
              ),
            )
          ],
        )));
  }
}

class RateInput extends StatelessWidget {
  RateInput(
      {this.rate,
      this.onfifthClick,
      this.onfourthClick,
      this.onthirdClick,
      this.onsecondClick,
      this.onfirstClick,
      this.color});
  final int rate;
  final Function onfirstClick;
  final Function onsecondClick;
  final Function onthirdClick;
  final Function onfourthClick;
  final Function onfifthClick;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(
              (rate >= 1) ? Icons.star : Icons.star_border,
              color: color,
              size: 40,
            ),
            onTap: onfirstClick,
          ),
          GestureDetector(
            child: Icon(
              (rate >= 2) ? Icons.star : Icons.star_border,
              color: color,
              size: 40,
            ),
            onTap: onsecondClick,
          ),
          GestureDetector(
            child: Icon(
              (rate >= 3) ? Icons.star : Icons.star_border,
              color: color,
              size: 40,
            ),
            onTap: onthirdClick,
          ),
          GestureDetector(
            child: Icon(
              (rate >= 4) ? Icons.star : Icons.star_border,
              color: color,
              size: 40,
            ),
            onTap: onfourthClick,
          ),
          GestureDetector(
            child: Icon(
              (rate >= 5) ? Icons.star : Icons.star_border,
              color: color,
              size: 40,
            ),
            onTap: onfifthClick,
          ),
        ],
      ),
    );
  }
}
