import 'package:flutter/material.dart';

typedef void OnTap();

class BundleButton extends StatelessWidget {
  BundleButton.build({
    @required this.text,
    @required this.icon,
    this.backColor = Colors.white,
    @required this.onTap,
  });

  final Widget text;
  final Widget icon;
  final Color backColor;
  final OnTap onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: Material(
        color: backColor,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        shadowColor: Colors.black54,
        elevation: 3,
        child: MaterialButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              text,
            ],
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
