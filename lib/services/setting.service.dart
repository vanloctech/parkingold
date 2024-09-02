import 'package:parkingold/services/base.service.dart';

import '../database/database.dart';
import '../models/setting.model.dart';

class SettingService {
  /// Get value by key
  Future<dynamic> getByKeys(List<String> keys) async {
    final apiService = APIService.instance;

    try {
      final response = await apiService
          .request('settings', DioMethod.get, param: {'name': keys}, requireToken: true);
      if (response.statusCode == 200) {
        print('API call successful: ${response.data}');
        return response.data.data;
      } else {
        print('API call failed: ${response.statusMessage}');
      }
    } catch (e) {
      print('Network error occurred: $e');
    }

    return null;
  }

  /// Create or update setting
  Future<dynamic> createOrUpdate(String key, String value) async {
    try {
      final response = await APIService.instance
          .request('settings', DioMethod.post, param: {'name': key, 'value': value}, requireToken: true);
      if (response.statusCode == 200) {
        print('API call successful: ${response.data}');
        return response.data.data;
      } else {
        print('API call failed: ${response.statusMessage}');
      }
    } catch (e) {
      print('Network error occurred: $e');
    }

    return null;
  }
}
