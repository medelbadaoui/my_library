import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {@required this.btnText,
      @required this.btnColor,
      @required this.textColor,
      @required this.onClick});
  final String btnText;
  final Color btnColor;
  final Color textColor;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Material(
          color: btnColor,
          borderRadius: BorderRadius.circular(40.0),
          child: MaterialButton(
            onPressed: onClick,
            minWidth: 150.0,
            height: 60.0,
            child: Text(
              btnText,
              style: GoogleFonts.redHatText(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
