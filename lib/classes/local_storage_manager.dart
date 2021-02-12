import 'package:localstorage/localstorage.dart';

class LocalStorageManager {

  	LocalStorage _localStorage;
	Map<String, dynamic> _storagePendingItems = {};
	Future<void> _savingPendingStorageItems;

	Future<bool> get ready => _localStorage.ready;

	LocalStorageManager(String fileName) {
		_localStorage = new LocalStorage(fileName, null, {});
	}

	void setItem(String key, dynamic value) {
		_storagePendingItems[key] = value;

		if (_savingPendingStorageItems == null) { 
			_savingPendingStorageItems = _processPendingStorageItems();
		}
	}

	Future<dynamic> getItem(String key) async {
		dynamic value = _storagePendingItems[key];

		if ((value?.isEmpty ?? true) && _localStorage != null && await _localStorage.ready) {
			value = _localStorage.getItem(key);
		}

		return value;
	}

	Future<void> _processPendingStorageItems() async {
		List<String> pendingKeys = _storagePendingItems.keys.toList();

		if (pendingKeys.length > 0) {
			await ready;

			for (String key in pendingKeys) {
				await _localStorage.setItem(key, _storagePendingItems[key]);
				_storagePendingItems.remove(key);
			}

			if (_storagePendingItems.length > 0) {			
				_savingPendingStorageItems = _processPendingStorageItems();
			} else {
				_savingPendingStorageItems = null;
			}

		} else {
			_savingPendingStorageItems = null;
		}
	}
}