const MESSAGE = 'Message';
const SYS_MESSAGE = 'SystemMessage';

class MessageBody {
  final String _type;
  final dynamic _data;

  MessageBody.fromMap(Map<String, dynamic> map)
      : this._type = map['type'],
        this._data = map['data'];

  String get type => this._type;

  String get data => this._data;
}
