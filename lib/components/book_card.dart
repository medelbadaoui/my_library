import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookCard extends StatelessWidget {
  BookCard(
      {@required this.bookid,
      @required this.bookimageurl,
      @required this.bookwriter,
      @required this.booktitle});
  final String bookid;
  final String bookimageurl;
  final String bookwriter;
  final String booktitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 190,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      bookimageurl,
                    ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black12,
                ),
              )),
          SizedBox(
            height: 19,
          ),
          Expanded(
            child: Text(
              bookwriter,
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 13),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 2,
            child: Text(
              booktitle,
              style: GoogleFonts.exo(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          )
        ],
      ),
    );
  }
}
