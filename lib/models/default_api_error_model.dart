import 'dart:convert';

class DefaultApiErrorModel {
	String message;
	String solution;

	DefaultApiErrorModel.fromJson(dynamic json) {
		if (json is String) {
		json = jsonDecode(json);
		}

		this.message = json['message'];
		this.solution = json['solution'];
	}
}