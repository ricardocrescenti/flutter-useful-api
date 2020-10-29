import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:useful_api/useful_api.dart';

class DefaultApiResponseModel {
  dynamic json;
  dynamic data;
  DefaultApiErrorModel error;
  DateTime serverTime;

  operator [](String fieldName) => data[fieldName];

  DefaultApiResponseModel.fromJson(dynamic json) {
    this.json = (json is String ? jsonDecode(json) : json);
    this.data = json['data'];
    this.error = (json['error'] != null ? DefaultApiErrorModel.fromJson(json['error']) : null);
    this.serverTime = DateTime.tryParse(json['serverTime']);
  }
}