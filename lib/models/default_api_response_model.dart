import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:useful_api/useful_api.dart';

class DefaultApiResponseModel {
  dynamic data;
  DefaultApiErrorModel error;
  DateTime serverTime;

  operator [](String fieldName) => data[fieldName];

  DefaultApiResponseModel.fromJson(dynamic json) {
    if (json is String) {
      json = jsonDecode(json);
    }

    this.data = json['data'];
    this.error = (json['error'] != null ? DefaultApiErrorModel.fromJson(json['error']) : null);
    this.serverTime = DateTime.tryParse(json['serverTime']);
  }
}