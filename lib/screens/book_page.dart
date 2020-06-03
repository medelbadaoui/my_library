import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylibrary/components/categorie_listtile.dart';

class BookPage extends StatefulWidget {
  static const id = 'book_page';
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
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
                SizedBox(
                  height: 120,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Color(0xFFD8F2E6),
                          child: Text(
                            'Self Development',
                            style: TextStyle(color: Colors.green),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            'Simon Sinek',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 17),
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
                            'Start With Why',
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
                          children: <Widget>[
                            CategorieListTile(
                                name: 'About Book', selected: true),
                            CategorieListTile(
                                name: "Owner's Infos", selected: false),
                            CategorieListTile(name: "Reviews", selected: false)
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
                                content: '5.0',
                              ),
                              AboutBook(
                                id: 'Pages',
                                content: '412',
                              ),
                              AboutBook(
                                id: 'Language',
                                content: 'English',
                              ),
                              AboutBook(
                                id: 'Year',
                                content: '2019',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
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
                            Text(
                                'In 2009, Simon Sinek started a movement to help people become more inspired at work, and in turn inspire their colleagues and customers. Since then, millions have been touched by the power of his ideas, including more than 28 million who’ve watched his TED Talk based on START WITH WHY -- the third most popular TED video of all time.')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 75, right: 100.0, left: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Colors.white,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://simonsinek.com/wp-content/uploads/2018/09/SWW-Cover-High-Res.jpg',
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
        ],
      ),
    );
  }
}

class AboutBook extends StatelessWidget {
  AboutBook({@required this.id, @required this.content});
  final String id;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            id,
            style: TextStyle(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.w100),
          ),
          SizedBox(
            height: 5,
          ),
          Text(content, style: TextStyle(fontSize: 15, color: Colors.black)),
        ],
      ),
    );
  }
}
