import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorieCard extends StatelessWidget {
  CategorieCard(
      {@required this.catName,
      @required this.booksNumber,
      @required this.onClick});
  Function onClick;

  final String catName;
  final String booksNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 90,
        width: 130,
        margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  catName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 11.5,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                booksNumber + ' Books',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(fontSize: 10, color: Colors.green)),
              )
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
      ),
    );
  }
}
