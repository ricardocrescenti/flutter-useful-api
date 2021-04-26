import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:useful_api/classes/rest_api.dart';
import 'package:useful_api/useful_api.dart';

abstract class ApiServiceMixin {
  final Dio dio = Dio();

  LocalStorageManager _localStorageManager;
  LocalStorageManager get localStorageManager => _localStorageManager;

  RestApi _rest;
  RestApi get rest => _rest;

  GraphQLApi _graphQL;
  GraphQLApi get graphQL => _graphQL;

  void initializeDio(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers.putIfAbsent('Accept', () => 'application/json');
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request) {
        request.data = adjustRequestData(request.data);
        return request;
      },
    ));
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: this.onRequest,
      onResponse: this.onResponse,
      onError: this.onError,
    ));

    _rest = new RestApi(apiService: this);
  }

  dynamic adjustRequestData(dynamic data) {
    if (data == null) {
      return null;
    }

    if (data is Map) {
      for (String key in data.keys) {
        data[key] = adjustRequestData(data[key]);
      }
    } else if (data is List) {
      for (int i = 0; i < data.length; i++) {
        data[i] = adjustRequestData(data[i]);
      }
    } else if (data is DateTime) {
      data = data.toString();
    }

    return data;
  }

  GraphQLApi initializeGraphQL({String routePath = 'graphql'}) {
    _graphQL = GraphQLApi(
      apiService: this,
      routePath: routePath);
    return graphQL;
  }

  Future<bool> initializeCache({String fileName}) {
    _localStorageManager = new LocalStorageManager('cache_' + (fileName == null || fileName.isEmpty ? this.runtimeType.toString() : fileName) + '.json');
    return localStorageManager.ready;
  }
  
  dynamic onRequest(RequestOptions request) async => request;
  dynamic onResponse(Response<dynamic> response) async {
    response.data = DefaultApiResponseModel.fromJson(response.data);
    if (response.data.error != null) {
      throw response.data;
    }
    return response;
  }
  dynamic onError(DioError error) async {
    if (error.response != null) {
      error.response.data = DefaultApiResponseModel.fromJson(error.response.data);
    }
    return error;
  }

  Future<void> processError(BuildContext context, DioError error);
}