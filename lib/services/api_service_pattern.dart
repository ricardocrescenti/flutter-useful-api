import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:useful_api/classes/rest_api.dart';
import 'package:useful_api/useful_api.dart';

abstract class ApiServicePattern {
  final Dio dio = Dio();

  LocalStorage _localStorage;
  LocalStorage get localStorage => _localStorage;

  RestApi _rest;
  RestApi get rest => _rest;

  GraphQLApi _graphQL;
  GraphQLApi get graphQL => _graphQL;


  initializeDio(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers.putIfAbsent('Accept', () => 'application/json');
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: this.onRequest,
      onResponse: this.onResponse,
      onError: this.onError,
    ));

    _rest = new RestApi(apiService: this);
  }
  
  Future<bool> initializeCache({String fileName}) {
    _localStorage = new LocalStorage('cache_' + (fileName == null || fileName.isEmpty ? this.runtimeType.toString() : fileName) + '.json', null, {});
    return _localStorage.ready;
  }

  GraphQLApi initializeGraphQL({String routePath = 'graphql'}) {
    _graphQL = GraphQLApi(
      apiService: this,
      routePath: routePath);
    return graphQL;
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
      error.response.data = DefaultApiResponseModel.fromJson(error);
    }
    return error;
  }

}