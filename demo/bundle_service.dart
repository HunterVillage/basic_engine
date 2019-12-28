import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:basic_engine/widgets/dialogs/expound_dialog.dart';
import 'package:flutter/material.dart';

class BundleService extends StatelessBundle {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: icon,
        title: Text('service', style: TextStyle(color: Colors.black, fontFamily: 'pinshang')),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.orange,
          onPressed: () => showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ExpoundDialog(
                title: '升级提醒',
                content: '本程序将在一天后发布新版本，请做好相应的升级准备。',
              );
            },
          ),
          child: Text('expond dialog test'),
        ),
      ),
    );
  }

  @override
  Widget get icon => Icon(MyIcons.service, color: Colors.blueGrey);

  @override
  String get id => 'service';

  @override
  int get sort => 3;

  @override
  String get cnName => 'service';
}
