import 'dart:convert';

class DefaultApiErrorModel {

	List<String>? messages;
	String? solution;

	DefaultApiErrorModel.fromJson(dynamic json) {

		if (json is String) {

			if (json.startsWith('{') || json.startsWith('[')) {
				json = jsonDecode(json);
			} else {
				json = {
					'messages': [json],
					'message': json
				};
			}

		}

		if (json['messages'] != null) {
			this.messages = (json['messages'] as List).cast<String>();
		} else {
			this.messages = [];
		}

		if (json['message'] != null) {
			this.messages!.add(json['message']);
		}

		this.solution = json['solution'];

	}

}