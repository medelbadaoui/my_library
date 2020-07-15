import 'package:flutter/material.dart';

class CategorieListTile extends StatelessWidget {
  CategorieListTile(
      {@required this.name, this.selected, @required this.onClick});
  final String name;
  final bool selected;
  Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: (selected ? FontWeight.w500 : FontWeight.w300)),
              textAlign: TextAlign.center,
            ),
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: selected,
              child: Image.asset(
                'images/selectedicon.png',
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
