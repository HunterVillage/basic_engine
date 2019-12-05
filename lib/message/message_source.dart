
import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/message_listener.dart';

class MessageSource {
  final Set<MessageListener> listeners = new Set();
  static final _instance = new MessageSource._();

  MessageSource._();

  static MessageSource getInstance() {
    return _instance;
  }

  void install(MessageListener listener) {
    listeners.add(listener);
  }

  void uninstall(MessageListener listener) {
    listeners.remove(listener);
  }

  void fireEven(MessageBody messageBody) {
    listeners.forEach((listener) => listener.onReceiveMessage(messageBody));
  }
}
