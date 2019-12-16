import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final String title;
  final String content;

  NewsDetail(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(title),
            Divider(),
            Text(content),
          ],
        ),
      ),
    );
  }
}
