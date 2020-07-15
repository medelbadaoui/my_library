import 'package:flutter/material.dart';

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
