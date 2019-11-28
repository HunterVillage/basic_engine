import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/login/login_request.dart';
import 'package:flutter/material.dart';

class PersonCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonCenterState();
}

class PersonCenterState extends State<PersonCenter> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () => LoginRequest.logOut(context),
        child: Text('Logout'),
      ),
    );
  }
}
