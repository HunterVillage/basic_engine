import 'package:basic_engine/common/login_control.dart';
import 'package:basic_engine/widgets/tip_bar.dart';
import 'package:basic_engine/widgets/tips_tool.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class DioClient<T> {
  final Dio _dio = new Dio(BaseOptions(
    connectTimeout: 60000,
    receiveTimeout: 60000,
    responseType: ResponseType.json,
  ));

  Global _global;

  Future<ResponseBody<T>> post(url, {params}) async {
    _global = await Global.getInstance();
    _dio.options.headers = {'Authorization': 'Bearer ' + _global.token};
    _dio.options.baseUrl = _global.baseUrl;

    Response<Map<String, dynamic>> response;
    try {
      response = await _dio.post(url, data: params);
    } on DioError catch (e) {
      print(e);
      TipsTool.error('网络异常').show();
    }
    if (response != null) {
      ResponseBody<T> responseBody = ResponseBody<T>.fromMap(response.data);
      if (responseBody.token != null) {
        _global.setToken(responseBody.token);
      }
      if (responseBody.resend ?? false) {
        return post(url, params: params);
      }
      return responseBody;
    } else {
      return null;
    }
  }

  Future<ResponseBody<T>> get(url, {params}) async {
    _global = await Global.getInstance();
    _dio.options.headers = {'Authorization': 'Bearer ' + _global.token};
    _dio.options.baseUrl = _global.baseUrl;

    Response<Map<String, dynamic>> response;
    try {
      response = await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      print(e);
      TipsTool.error('网络异常').show();
    }
    if (response != null) {
      ResponseBody<T> responseBody = ResponseBody<T>.fromMap(response.data);
      if (responseBody.token != null) {
        _global.setToken(responseBody.token);
      }
      if (responseBody.resend) {
        return get(url, params: params);
      }
      if (responseBody.reLogin) {
        LoginControl.getInstance().logOut();
      }
      return responseBody;
    } else {
      return null;
    }
  }

  Future download(BuildContext context, url, {Map<String, dynamic> queryParameters, @required path}) async {
    _global = await Global.getInstance();
    _dio.options.headers = {'Authorization': 'Bearer ' + _global.token};
    _dio.options.baseUrl = _global.baseUrl;
    _dio.options.responseType = ResponseType.stream;

    Response response = await _dio.download('url', path, queryParameters: queryParameters);
    if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(TipBar.build('网络异常'));
    }
  }
}

class ResponseBody<T> {
  final bool _success;
  final String _category;
  final T _data;
  final String _title;
  final String _message;
  final bool _resend;
  final String _token;
  final bool _reLogin;

  ResponseBody.fromMap(Map<String, dynamic> map)
      : _success = map['success'],
        _category = map['category'],
        _data = map['data'],
        _title = map['title'],
        _message = map['message'],
        _resend = map['resend'],
        _token = map['token'],
        _reLogin = map['reLogin'];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'success': this._success,
        'category': this._category,
        'data': this._data,
        'title': this._title,
        'message': this._message,
        'resend': this._resend,
        'token': this._token,
        'reLogin': this._reLogin,
      };

  bool get success => _success;

  String get token => _token;

  String get message => _message;

  String get title => _title;

  String get category => _category;

  T get data => _data;

  bool get resend => _resend;

  bool get reLogin => _reLogin;
}
