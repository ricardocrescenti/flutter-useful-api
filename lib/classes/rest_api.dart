import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:useful_api/useful_api.dart';

class RestApi {
	final ApiServicePattern apiService;
	final String routePath;  
	
	RestApi({
		@required this.apiService,
		this.routePath,
	});

	delete<T>(String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, T Function(dynamic response) convertData}) {
		final dynamic response = apiService.dio.delete(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
		return (convertData != null ? convertData(response) : response);
	}

	get<T>(String path, {Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) {
		final dynamic response = apiService.dio.get(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
		return (convertData != null ? convertData(response) : response);
	}

	head<T>(String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, T Function(dynamic response) convertData}) {
		final dynamic response = apiService.dio.head(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
		return (convertData != null ? convertData(response) : response);
	}

	patch<T>(String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) {
		final dynamic response = apiService.dio.patch(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
		return (convertData != null ? convertData(response) : response);
	}

	post<T>(String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) {
		final dynamic response = apiService.dio.post(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
		return (convertData != null ? convertData(response) : response);
	}

	put<T>(String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) {
		final dynamic response = apiService.dio.put(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
		return (convertData != null ? convertData(response) : response);
	}

	request<T>(String path, {dynamic data, Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken, ProgressCallback onSendProgress, ProgressCallback onReceiveProgress, T Function(dynamic response) convertData}) {
		final dynamic response = apiService.dio.request(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
		return (convertData != null ? convertData(response) : response);
	}
}