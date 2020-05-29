import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/components/book_card.dart';
import 'package:mylibrary/components/categorie_card.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.topLeft,
          image: NetworkImage('https://wallpapercave.com/wp/wp2297884.jpg'),
        )),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(0, 0),
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                margin: EdgeInsets.all(20),
                child: CupertinoTextField(
                  style: GoogleFonts.firaSans(
                      textStyle: TextStyle(color: Colors.grey)),
                  prefix: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffix: Icon(
                    Icons.language,
                    color: Colors.grey,
                  ),
                ),
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
                            child: Text('see all',
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey),
                                )),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          BookCard(
                              bookimageurl:
                                  'https://images-na.ssl-images-amazon.com/images/I/71t4GuxLCuL.jpg',
                              bookwriter: 'Mark Manson',
                              booktitle: 'The Subtle Art Of Not Giving A Fuck'),
                          BookCard(
                              bookimageurl:
                                  'https://prodimage.images-bn.com/pimages/9781476740058_p0_v3_s550x406.jpg',
                              bookwriter: 'Stephen R. Covey',
                              booktitle: '7 Habits Of Highly Effective People'),
                          BookCard(
                              bookimageurl:
                                  'https://images-na.ssl-images-amazon.com/images/I/71QUhm-AnIL.jpg',
                              bookwriter: 'Simon Sinek',
                              booktitle: 'Start With Why'),
                          BookCard(
                              bookimageurl:
                                  'https://images-na.ssl-images-amazon.com/images/I/71GLAwC9cPL.jpg',
                              bookwriter: 'Malcom Gladwell',
                              booktitle: 'Outliers'),
                          BookCard(
                              bookimageurl:
                                  'https://images-na.ssl-images-amazon.com/images/I/51ocbzYsk4L.jpg',
                              bookwriter: 'Robert T. Kiyosaki',
                              booktitle: 'Rich Dad Poor Dad'),
                        ],
                      ),
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
                    child: Text(
                      'see all',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  CategorieCard(
                    catName: 'Economy',
                    booksNumber: '208',
                    catIcon: Icons.monetization_on,
                  ),
                  CategorieCard(
                    catName: 'Architecture',
                    booksNumber: '208',
                    catIcon: Icons.business,
                  ),
                  CategorieCard(
                    catName: 'Design',
                    booksNumber: '57',
                    catIcon: Icons.border_color,
                  ),
                  CategorieCard(
                    catName: 'Poetry',
                    booksNumber: '29',
                    catIcon: Icons.local_florist,
                  ),
                  CategorieCard(
                    catName: 'Computer Science',
                    booksNumber: '100',
                    catIcon: Icons.laptop,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
