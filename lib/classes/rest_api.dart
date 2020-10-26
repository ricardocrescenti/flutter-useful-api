import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:useful_api/useful_api.dart';

class RestApi {
	final ApiServiceMixin apiService;
	final String routePath;  
	
	RestApi({
		@required this.apiService,
		this.routePath,
	});

	Future<T> delete<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, T Function(dynamic response) convertData}) async {
		final dynamic response = await apiService.dio.delete(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken)
			.catchError((error) async { await apiService.processError(context, error); });
		return (response != null ? (convertData != null ? convertData(response) : response) : null);
	}

	Future<T> get<T>(BuildContext context, String path, {Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) async {
		final dynamic response = await apiService.dio.get(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress)
			.catchError((error) async { await apiService.processError(context, error); });
		return (response != null ? (convertData != null ? convertData(response) : response) : null);
	}

	Future<T> head<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, T Function(dynamic response) convertData}) async {
		final dynamic response = await apiService.dio.head(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken)
			.catchError((error) async { await apiService.processError(context, error); });
		return (response != null ? (convertData != null ? convertData(response) : response) : null);
	}

	Future<T> patch<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) async {
		final dynamic response = await apiService.dio.patch(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress)
			.catchError((error) async { await apiService.processError(context, error); });
		return (response != null ? (convertData != null ? convertData(response) : response) : null);
	}

	Future<T> post<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) async {
		final dynamic response = await apiService.dio.post(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress)
			.catchError((error) async { await apiService.processError(context, error); });
		return (response != null ? (convertData != null ? convertData(response) : response) : null);
	}

	Future<T> put<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) async {
		final dynamic response = await apiService.dio.put(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress)
			.catchError((error) async { await apiService.processError(context, error); });
		return (response != null ? (convertData != null ? convertData(response) : response) : null);
	}

	Future<T> request<T>(BuildContext context, String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) async {
		final dynamic response = await apiService.dio.request(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress)
			.catchError((error) async { await apiService.processError(context, error); });
		return (response != null ? (convertData != null ? convertData(response) : response) : null);
	}
}