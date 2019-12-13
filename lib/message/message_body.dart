const COMMON_MESSAGE = 'CommonMessage';
const SYS_MESSAGE = 'SystemMessage';

class MessageBody {
  final String _type;
  final String _cmd;
  final String _title;
  final String _content;
  final dynamic _detail;

  MessageBody.fromMap(Map<String, dynamic> map)
      : this._type = map['type'],
        this._cmd = map['cmd'],
        this._title = map['title'],
        this._content = map['content'],
        this._detail = map['detail'];

  static List<MessageBody> allFromMap(List jsonList) {
    return jsonList
        .map((json) => MessageBody.fromMap(json))
        .toList();
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'type': this._type,
    'cmd': this._cmd,
    'title': this._title,
    'content': this._content,
    'detail': this._detail,
  };

  String get type => this._type;

  String get cmd => _cmd;

  dynamic get detail => _detail;

  String get content => _content;

  String get title => _title;
}
