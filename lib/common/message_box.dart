import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:rxdart/subjects.dart';

final PublishSubject<List<MessageBody>> messageBoxSubject = PublishSubject<List<MessageBody>>();

/// @author wujianchuan
/// @date 2019/12/17 17:06
class MessageBox {
  static MessageBox _instance;
  static final List<MessageBody> _unreadMessageList = [];
  static final List<MessageBody> _alreadyReadMessageList = [];

  MessageBox._();

  static MessageBox getInstance() {
    if (_instance == null) {
      _instance = MessageBox._();
      socketMessageSubject.stream.listen((messageBody) => _instance.pushUnreadMessage(messageBody));
    }
    return _instance;
  }

  void putAllUnreadMessage(List<MessageBody> messageBodyList) {
    _unreadMessageList.addAll(messageBodyList);
  }

  void pushUnreadMessage(MessageBody messageBody) {
    _unreadMessageList.add(messageBody);
    messageBoxSubject.add(allMessage());
  }

  MessageBody popUnreadMessage(String uuid) {
    MessageBody messageBody = _unreadMessageList.singleWhere((item) => item.uuid == uuid);
    _unreadMessageList.remove(messageBody);
    _alreadyReadMessageList.add(messageBody);
    messageBoxSubject.add(allMessage());
    return messageBody;
  }

  void putAllAlreadyReadMessage(List<MessageBody> messageBodyList) {
    _alreadyReadMessageList.addAll(messageBodyList);
  }

  void pushAlreadyReadMessage(MessageBody messageBody) {
    _alreadyReadMessageList.add(messageBody);
  }

  void clear() {
    _unreadMessageList.clear();
    _alreadyReadMessageList.clear();
  }

  List<MessageBody> allMessage() {
    List<MessageBody> allMessage = [];
    allMessage.addAll(_unreadMessageList);
    allMessage.addAll(_alreadyReadMessageList);
    return allMessage;
  }

  List<MessageBody> unreadMessage() {
    return _unreadMessageList;
  }
}
