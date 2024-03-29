import 'package:useful_api/useful_api.dart';

class GraphQLSchema {

	final GraphQLApi graphQLClient;
	final String name;
	List<Object> fields;

	GraphQLSchema(this.graphQLClient, this.name, { required this.fields });

	List<dynamic> graphQLFields() {
		return _graphQLFields(fields).values.toList();
	}

	Map<String, dynamic> _graphQLFields(List<dynamic> fields) {

		Map<String, dynamic> graphQLFields = {};
		fields.forEach((field) {
			if (field.length == 1) {

				if (field.first.startsWith('{') && field.first.endsWith('}')) {
					
					String schemaName = field.first.substring(1, field.first.length - 1);
					GraphQLSchema graphQLSchema = graphQLClient.schemas[schemaName]!;
					graphQLSchema._graphQLFields(graphQLSchema.fields).forEach((key, value) {
						graphQLFields[key] = value;
					});

				} else {
					graphQLFields[field.first] = field.first;
				}
			
			} else {

				graphQLFields[field.first] = { field.first: _graphQLFields(field.last).values.toList() };

			}
		});

		return graphQLFields;

	}
}