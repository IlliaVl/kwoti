import 'dart:io';

import 'package:dio/dio.dart';

/// Handles all communication with the backend
abstract class NetClient {
  /// The HTTP client.
  final Dio _client;

  /// Creates new [NetClient] with provided [baseUrl]
  NetClient({required String baseUrl})
      : _client = Dio(
          BaseOptions(baseUrl: baseUrl),
        );

  /// Calls request to [path] with the optional [queryParameters]
  Future<Response> call(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _client.get(
        path,
        queryParameters: queryParameters,
      );

      return response;
    } on DioError catch (e) {
      print('Error: ${e.message}');
      rethrow;
    }
  }

  /// Checks if there is internet connection
  Future<bool> connected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
