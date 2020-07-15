import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  ReviewItem(
      {this.image, this.comment, this.rate, this.username, this.onImageClick});

  final String image;
  final String comment;
  final double rate;
  final String username;
  final Function onImageClick;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        padding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.white,
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
        child: ListTile(
          leading: GestureDetector(
            onTap: onImageClick,
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
          subtitle: Text(
            comment,
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
          title: generatestars(rate.round(), username),
        ));
  }
}

Widget generatestars(int number, String username) {
  int tmp = 5 - number;
  return Container(
    child: Row(
      children: <Widget>[
        Text(
          username,
          style: TextStyle(fontSize: 18),
        ),
        for (int i = 0; i < number; i++)
          Icon(
            Icons.star,
            size: 20,
            color: Colors.yellow,
          ),
        for (int j = 0; j < tmp; j++)
          Icon(
            Icons.star_border,
            size: 20,
            color: Colors.yellow,
          ),
      ],
    ),
  );
}
