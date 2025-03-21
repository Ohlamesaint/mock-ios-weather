import 'package:dio/dio.dart' show Dio, DioException, Response;
import 'package:flutter/foundation.dart' show debugPrint;

class HttpUtils {
  static final Dio _dio = Dio();

  static Future<Response<T>> httpGet<T>(
      {required String url, required Map<String, String> queries}) async {
    // Add queries to the URL
    final uri = Uri.parse(url).replace(queryParameters: queries);
    final combinedUrl = uri.toString();

    debugPrint('GET: $combinedUrl');

    try {
      final response = await _dio.get<T>(combinedUrl);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        // Server error
        debugPrint('Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        // Request error
        debugPrint('Error: ${e.message}');
      }
      rethrow;
    } catch (e) {
      // Handle other errors
      debugPrint('Unexpected error: $e');
      rethrow;
    }
  }
}
