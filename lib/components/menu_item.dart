import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {@required this.title, @required this.icon, this.selected, this.onClick});
  final String title;
  final IconData icon;
  final bool selected;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 45,
        width: double.infinity,
        color: Color(0xFFF2F4F3),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: (selected) ? Colors.black : Colors.grey,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: GoogleFonts.play(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: (selected) ? Colors.black : Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
