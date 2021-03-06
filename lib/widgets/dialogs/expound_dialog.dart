import 'package:flutter/material.dart';

/// @author wujianchuan
/// @date 2019/12/28 17:56
class ExpoundDialog extends StatelessWidget {
  final String title;
  final String content;
  final double width;
  final double height;

  ExpoundDialog({
    @required this.title,
    @required this.content,
    this.width = 280,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//            margin: EdgeInsets.only(bottom: 90),
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              children: <Widget>[
                Text(title, style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 18, decoration: TextDecoration.none, fontFamily: 'pinshang')),
                Divider(),
                Expanded(
                  child: SizedBox(
                    width: width - 20,
                    child: SingleChildScrollView(
                      child: Text(content,
                          style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.normal)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: VerticalDivider(color: Theme.of(context).cardColor),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.highlight_off,
                    color: Theme.of(context).cardColor,
                    size: 30,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
