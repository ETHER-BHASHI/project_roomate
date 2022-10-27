import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/util/constants.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedOutlinedButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: OutlinedButton(
          child: Text(text),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.teal,
            side: BorderSide(color: Colors.red, width: 5),
          ),
          onPressed: () {
            print('Pressed');
          },
          /*highlightedBorderColor: kAccentColor,
          borderSide: BorderSide(color: kSecondaryColor, width: 2.0),
          child: Text(text, style: Theme.of(context).textTheme.button),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),*/
        ));
  }
}

