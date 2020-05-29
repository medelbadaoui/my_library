import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorieCard extends StatelessWidget {
  CategorieCard(
      {@required this.catName,
      @required this.booksNumber,
      @required this.catIcon});

  final String catName;
  final String booksNumber;
  final IconData catIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 130,
      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
      padding: EdgeInsets.fromLTRB(17, 12, 17, 0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Icon(
                catIcon,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: Text(
              catName,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 11.5,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Expanded(
                child: Text(
              booksNumber + ' Books',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(fontSize: 10, color: Colors.green)),
            ))
          ],
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0, 5),
            blurRadius: 5.0,
            spreadRadius: 0.0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
        ),
      ),
    );
  }
}
