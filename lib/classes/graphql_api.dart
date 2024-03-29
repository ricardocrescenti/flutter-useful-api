import 'package:dio/dio.dart';
import 'package:useful_api/useful_api.dart';

class GraphQLApi {

	final ApiServiceMixin apiService;
	final String? routePath;

	final Map<String, GraphQLSchema> schemas = {};

	GraphQLApi({
		required this.apiService,
		this.routePath,
	});

	GraphQLSchema addSchema(String name, List<Object> fields) {

		GraphQLSchema graphQLSchema = GraphQLSchema(this, name, fields: fields);
		schemas[name] = graphQLSchema;
		return graphQLSchema;

	}

	Future<T> query<T>(String queryName, {String? schemaName, Map<String, dynamic>? args, T Function(dynamic data)? convertion, ApiCacheCallback? cache}) async {

		dynamic data;
		convertion ??= (data) => data;

		Future<Response> futureResponse = _post(GraphQLJsonBuilder
			.query(queryName)
			.addArgs(args)
			.addFields(schemas[schemaName ?? queryName]!.graphQLFields()));

		if (cache != null) {

			assert(apiService.localStorageManager != null, 'You can be initialize cache');

			dynamic localCache = await apiService.localStorageManager!.getItem(cache.name);
			if (localCache != null) {
				data = localCache;
			}

			futureResponse.then((response) {

				apiService.localStorageManager!.setItem(cache.name, (response.data is DefaultApiResponseModel ? response.data.toJson() : response.data));
				if (localCache != null && cache.onGetData != null) {
					cache.onGetData!(convertion!(response.data));
				}

			});

		}

		if (data == null || cache?.onGetData == null) {
			data = await futureResponse;
		}

		return convertion(data);

	}

	Future<T> mutation<T>(String mutationName, {String? schemaName, Map<String, dynamic>? args, T Function(dynamic data)? convertion, String? cacheName}) async {

		Response response = await _post(GraphQLJsonBuilder
			.mutation(mutationName)
			.addArgs(args)
			.addFields(schemas[schemaName ?? mutationName]!.graphQLFields()));

		if (cacheName != null && cacheName.isNotEmpty) {

			assert(apiService.localStorageManager != null, 'You can be initialize cache');
			apiService.localStorageManager!.setItem(cacheName, (response.data is DefaultApiResponseModel ? response.data.toJson() : response.data));

		}

		return (convertion == null ? response.data : convertion(response.data));

	}

	Future<Response<T>> _post<T>(GraphQLJsonBuilder jsonBuilder) async {

		Map data = jsonBuilder.toJson();

		Response response = await apiService.dio.post('graphql', data: data);
		response.data.data = (response.data.data.length > 0 ? response.data.data[jsonBuilder.resolverName] : null);
		
		return response as Response<T>;

	}

}