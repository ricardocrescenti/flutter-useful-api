import 'dart:convert';

class DefaultApiErrorModel {
	List<String> messages;
	String solution;

	DefaultApiErrorModel.fromJson(dynamic json) {
		if (json is String) {
			json = jsonDecode(json);
		}

		this.messages = (json['messages'] as List)?.cast<String>();
		if (json['message'] != null) {
			this.messages.add(json['message']);
		}
		this.solution = json['solution'];
	}
}