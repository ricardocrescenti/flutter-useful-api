import 'package:flutter/material.dart';
import 'package:useful_api/useful_api.dart';

class RestApi {
	final ApiServiceMixin apiService;
	
	RestApi({
		required this.apiService,
	});

	Future<T> delete<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, T Function(dynamic response)? convertData, ApiCacheCallback? cache}) async {
		return _processRequest(context, apiService.dio.delete(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken), convertData, cache); 
	}

	Future<T> get<T>(BuildContext context, String path, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress, T Function(dynamic response)? convertData, ApiCacheCallback? cache}) async {
		return _processRequest(context, apiService.dio.get(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress), convertData, cache);
	}

	Future<T> head<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, T Function(dynamic response)? convertData, ApiCacheCallback? cache }) async {
		return _processRequest(context, apiService.dio.head(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken), convertData, cache);
	}

	Future<T> patch<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress, T Function(dynamic response)? convertData, ApiCacheCallback? cache}) async {
		return _processRequest(context, apiService.dio.patch(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress), convertData, cache);
	}

	Future<T> post<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress, T Function(dynamic response)? convertData, ApiCacheCallback? cache}) async {
		return _processRequest(context, apiService.dio.post(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress), convertData, cache);
	}

	Future<T> put<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress, T Function(dynamic response)? convertData, ApiCacheCallback? cache}) async {
		return _processRequest(context, apiService.dio.put(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress), convertData, cache);
	}	

	Future<T> request<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress, T Function(dynamic response)? convertData, ApiCacheCallback? cache}) async {
		return _processRequest(context, apiService.dio.request(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress), convertData, cache);
	}

	Future<T> _processRequest<T>(BuildContext context, Future<Response> futureResponse, T Function(dynamic response)? convertData, ApiCacheCallback? cache) async {

		dynamic data;
		convertData ??= (response) => response;

		if (cache != null) {

			assert(apiService.localStorageManager != null, 'You can be initialize cache');

			dynamic localCache = await apiService.localStorageManager!.getItem(cache.name);
			if (localCache != null) {
				data = localCache;
			}

			futureResponse.then((response) async {

				apiService.localStorageManager!.setItem(cache.name, (response.data is DefaultApiResponseModel ? response.data.json : response.data));
				if (localCache != null && cache.onGetData != null) {
					cache.onGetData!(convertData!(data));
				}

			});

		}

		if (data == null || cache?.onGetData == null) {

			try {
				Response response = await futureResponse;
				data = response.data;
			} catch (error) {
				await apiService.processError(context, error as DioError);
			}

		}

		return convertData(data);
	}
}