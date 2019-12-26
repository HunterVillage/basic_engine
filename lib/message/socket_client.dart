import 'dart:convert';
import 'dart:io';

import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/message/cmd_executor.dart';
import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:rxdart/rxdart.dart';

final BehaviorSubject<MessageBody> socketMessageSubject = BehaviorSubject<MessageBody>();

class SocketClient {
  static SocketClient _socketClient = new SocketClient._();
  WebSocket _webSocket;
  bool _isOpen;

  SocketClient._();

  static Future<SocketClient> getInstance() async {
    return _socketClient;
  }

  Future<bool> connect() async {
    UserInfo userInfo = app.userInfo;
    String serialNo = app.androidInfo.androidId;
    _webSocket = await WebSocket.connect(app.global.wsUrl, headers: {
      'avatar': userInfo.avatar,
      'serialNo': serialNo,
    }).catchError((e) {
      throw new Exception(e);
    });
    _webSocket.readyState;
    void onData(dynamic content) {
      MessageBody messageBody = MessageBody.fromMap(jsonDecode(content));

      if (SYSTEM_ACTION_MESSAGE == messageBody.type) {
        CmdExecutor.execute(messageBody.cmd);
      } else {
        socketMessageSubject.add(messageBody);
      }
    }

    _webSocket.listen(
      onData,
      onError: (error) {
        _isOpen = false;
        print("Websocket was interrupted by error: $error.");
      },
      onDone: () {
        _isOpen = false;
        print("Websocke has been closed.");
      },
    );
    _isOpen = true;
    print("Websocke has been connected.");
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
