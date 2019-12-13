import 'dart:convert';
import 'dart:io';

import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/common/global.dart';
import 'package:basic_engine/message/cmd_executor.dart';
import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/message_source.dart';
import 'package:basic_engine/model/user_info.dart';

class SocketClient {
  static SocketClient _socketClient = new SocketClient._();
  WebSocket _webSocket;
  bool _isOpen;
  static Global _global;

  SocketClient._();

  static Future<SocketClient> getInstance() async {
    _global = await Global.getInstance();
    return _socketClient;
  }

  Future<bool> connect() async {
    UserInfo userInfo = _global.userInfo;
    _webSocket = await WebSocket.connect(_global.wsUrl, headers: {'avatar': userInfo.avatar}).catchError((e) {
      throw new Exception(e);
    });
    _webSocket.readyState;
    void onData(dynamic content) {
      MessageBody messageBody = MessageBody.fromMap(jsonDecode(content));

      if (SYS_MESSAGE == messageBody.type) {
        CmdExecutor.execute(messageBody.cmd);
      } else {
        app.notifier.showBigTextNotification(messageBody.title, messageBody.content);
        MessageSource.getInstance().fireEven(messageBody);
      }
    }

    _webSocket.listen(
      onData,
      onError: (a) {
        print("error");
        _isOpen = false;
      },
      onDone: () {
        print("done");
        _isOpen = false;
      },
    );
    _isOpen = true;
    return _isOpen;
  }

  void closeSocket() {
    if (_isOpen) {
      _webSocket.close();
    }
  }

  sendMessage(String message) {
    if (!_isOpen) {
      connect().then((isOpen) => _webSocket.add(message));
    } else {
      _webSocket.add(message);
    }
  }
}
