import 'dart:io';

import 'package:basic_engine/widgets/tip_bar.dart';
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

  Future<ResponseBody<T>> post(BuildContext context, url, {params}) async {
    _global = await Global.getInstance();
    _dio.options.headers = {'token': 'Bearer ' + _global.token};
    _dio.options.baseUrl = _global.baseUrl;

    Response<Map<String, dynamic>> response;
    try {
      response = await _dio.post(url, data: params);
    } on DioError catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(TipBar.build('网络异常'));
    }
    if (response != null) {
      ResponseBody<T> responseBody = ResponseBody<T>.fromMap(response.data);
      if (responseBody.token != null) {
        _global.setToken(responseBody.token);
      }
      return responseBody;
    } else {
      return null;
    }
  }

  Future<ResponseBody<T>> get(BuildContext context, url, {params}) async {
    _global = await Global.getInstance();
    _dio.options.headers = {'token': 'Bearer ' + _global.token};
    _dio.options.baseUrl = _global.baseUrl;

    Response<Map<String, dynamic>> response;
    try {
      response = await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(TipBar.build('网络异常'));
    }
    if (response != null) {
      ResponseBody<T> responseBody = ResponseBody<T>.fromMap(response.data);
      if (responseBody.token != null) {
        _global.setToken(responseBody.token);
      }
      return responseBody;
    } else {
      return null;
    }
  }
}

class ResponseBody<T> {
  final bool _success;
  final String _category;
  final T _data;
  final String _title;
  final String _message;
  final String _token;

  ResponseBody.fromMap(Map<String, dynamic> map)
      : _success = map['success'],
        _category = map['category'],
        _data = map['data'],
        _title = map['title'],
        _message = map['message'],
        _token = map['token'];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'success': this._success,
        'category': this._category,
        'data': this._data,
        'title': this._title,
        'message': this._message,
        'token': this._token,
      };

  bool get success => _success;

  String get token => _token;

  String get message => _message;

  String get title => _title;

  String get category => _category;

  T get data => _data;
}
