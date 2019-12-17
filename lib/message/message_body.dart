const COMMON_MESSAGE = 'CommonMessage';
const SYSTEM_ACTION_MESSAGE = 'SystemActionMessage';

class MessageBody {
  final String _type;
  final String _cmd;
  final String _uuid;
  final String _sender;
  final String _title;
  final String _content;
  final bool _unread;

  MessageBody.fromMap(Map<String, dynamic> map)
      : this._type = map['type'],
        this._cmd = map['cmd'],
        this._title = map['title'],
        this._uuid = map['uuid'],
        this._sender = map['sender'],
        this._content = map['content'],
        this._unread = map['unread'];

  static List<MessageBody> allFromMap(List jsonList) {
    return jsonList.map((json) => MessageBody.fromMap(json)).toList();
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'type': this._type,
        'cmd': this._cmd,
        'uuid': this._uuid,
        'sender': this._sender,
        'title': this._title,
        'content': this._content,
        'unread': this._unread,
      };

  String get type => this._type;

  String get cmd => _cmd;

  String get content => _content;

  String get title => _title;

  String get uuid => _uuid;

  String get sender => _sender;

  bool get unread => _unread;
}
