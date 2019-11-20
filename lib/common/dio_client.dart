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

  Future<T> post(BuildContext context, url, {params}) async {
    _global = await Global.getInstance();
    _dio.options.headers = {'token': 'Bearer ' + _global.token};
    _dio.options.baseUrl = _global.baseUrl;

    Response<T> response;
    try {
      response = await _dio.post(url);
    } on DioError catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(TipBar.build('网络异常'));
    }
    if (response != null) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<T> get(BuildContext context, url, {params}) async {
    _global = await Global.getInstance();
    _dio.options.headers = {'token': 'Bearer ' + _global.token};
    _dio.options.baseUrl = _global.baseUrl;

    Response<T> response;
    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(TipBar.build('网络异常'));
    }
    if (response != null) {
      return response.data;
    } else {
      return null;
    }
  }
}
