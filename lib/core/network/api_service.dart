import 'dart:convert';
import 'package:http/http.dart' as http;


import '../utils/toast_util.dart';

class ApiService {
  static Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      print("===data===$data=");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ✅ Success
       
        return data;
      } else {
        // ❌ Error
        final message = data['error'] ?? 'Something went wrong';

        throw Exception(message);
      }
    } catch (e) {
      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : 'Something went wrong';

      ToastUtil.showError(errorMessage);

      rethrow;
    }
  }
}
