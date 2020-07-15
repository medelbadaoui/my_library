import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendItem extends StatelessWidget {
  FriendItem(
      {this.image, this.username, this.ondeleteaction, this.onclickaction});
  final String username;
  final String image;
  final Function ondeleteaction;
  final Function onclickaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.black12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0, 0),
            blurRadius: 1.1,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onclickaction,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(140)),
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
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: onclickaction,
              child: Container(
                child: Text(
                  username,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.athiti(textStyle: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: ondeleteaction,
              child: Container(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}