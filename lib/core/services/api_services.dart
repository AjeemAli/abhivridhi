import 'package:dio/dio.dart';
import 'package:get/get.dart' show Get, GetNavigation, GetxService;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';


class ApiService extends GetxService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://server1.pearl-developer.com/abhivriti/public/api/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 90,
  ));

  // Generic GET request
  Future<dynamic> getRequest(String endpoint,
      {Map<String, dynamic>? query, bool requiresAuth = false}) async {
    try {
      final headers = await _getAuthHeaders(requiresAuth);
      final response = await _dio.get(
        endpoint,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // Generic POST request
  Future<dynamic> postRequest(String endpoint,
      {dynamic data, bool requiresAuth = false}) async {
    try {
      final headers = await _getAuthHeaders(requiresAuth);
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // Generic DELETE request
  Future<dynamic> deleteRequest(String endpoint,
      {dynamic data, bool requiresAuth = false}) async {
    try {
      final headers = await _getAuthHeaders(requiresAuth);
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // Fetch Authorization Header if Required
  Future<Map<String, String>> _getAuthHeaders(bool requiresAuth) async {
    if (!requiresAuth) return {};

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found. Please log in again.');
    }
    print("Token Value $token");

    return {
      'Authorization': 'Bearer $token',
    };
  }

  // Updated response handler to allow both 200 and 201
  dynamic _handleResponse(Response response) {
    final statusCode = response.statusCode;
    if (statusCode == null) {
      throw Exception('Invalid response: No status code');
    }

    if (statusCode == 200 || statusCode == 201) {
      return response.data ?? {};
    } else {
      final errorMessage = response.data?['message'] ??
          response.statusMessage ??
          'Unknown error occurred';
      throw Exception('Error: $statusCode - $errorMessage');
    }
  }

  // Error handler
  void _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw Exception('Network timeout. Please try again.');
        case DioExceptionType.badResponse:
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            final errorData = error.response!.data;

            if (statusCode == 401 || statusCode == 422) {
              // Optional: Clear token from SharedPreferences
              SharedPreferences.getInstance().then((prefs) {
                prefs.remove('auth_token');
              });

              // Redirect to login screen
              Future.delayed(Duration.zero, () {
               Get.offAllNamed('/login');

              });

              final message = errorData is Map
                  ? errorData['message'] ?? 'Session expired. Please log in again.'
                  : 'Session expired. Please log in again.';
              throw Exception(message);
            }

            final message = errorData is Map
                ? errorData['message'] ?? error.response?.statusMessage ?? 'Server error'
                : error.response?.statusMessage ?? 'Server error';

            throw Exception('Server error ($statusCode): $message');
          }
          throw Exception('Server error: ${error.message}');
        case DioExceptionType.cancel:
          throw Exception('Request cancelled.');
        case DioExceptionType.connectionError:
          throw Exception('No Internet connection. Please check your network.');
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            throw Exception('No Internet connection. Please check your network.');
          }
          throw Exception('Unexpected error: ${error.message}');
        case DioExceptionType.badCertificate:
          throw Exception('Security error: Invalid certificate');
      }
    } else if (error is Exception) {
      throw error;
    } else {
      throw Exception('Unexpected error occurred. Please try again later.');
    }
  }

}




