import 'package:flutter/material.dart';

class BookImageCard extends StatelessWidget {
  BookImageCard({@required this.image, @required this.onClick});
  final String image;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 150,
        width: 90,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.black12,
          ),
          color: Colors.red,
        ),
      ),
    );
  }
}
