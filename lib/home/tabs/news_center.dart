import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/common/message_box.dart';
import 'package:basic_engine/home/tabs/news_detail.dart';
import 'package:basic_engine/message/message_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsCenterState();
}

class NewsCenterState extends State<NewsCenter> {
  List<dynamic> _allMessage = [];

  @override
  void initState() {
    super.initState();
    _allMessage = app.messageBox.allMessage();
    messageBoxSubject.stream.listen((values) {
      if (mounted) this.setState(() => _allMessage = values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 5),
      child: ListView.separated(
          itemCount: _allMessage.length,
          separatorBuilder: (BuildContext context, int index) => new Divider(),
          itemBuilder: (context, index) {
            MessageBody messageBody = _allMessage[index];
            return MessageItem(messageBody);
          }),
    );
  }
}

class MessageItem extends StatelessWidget {
  final MessageBody messageBody;

  MessageItem(this.messageBody);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(messageBody.uuid))),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10, left: 20),
            child: SizedBox(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(messageBody.sender ?? '', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), maxLines: 1),
                      Text('${messageBody.sendTime.month}/${messageBody.sendTime.day} ${messageBody.sendTime.hour}:${messageBody.sendTime.minute}',
                          style: TextStyle(fontSize: 13, color: Colors.black45), maxLines: 1),
                    ],
                  ),
                  Text(messageBody.title ?? '', style: TextStyle(fontSize: 14), maxLines: 1),
                  Text(
                    messageBody.content ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.black45),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 6,
            left: 5,
            child: Opacity(
              child: Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              opacity: messageBody.unread ? 1 : 0,
            ),
          )
        ],
      ),
    );
  }
}
