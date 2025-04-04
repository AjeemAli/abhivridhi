import 'package:dio/dio.dart';
import 'package:get/get.dart' show GetxService;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<String?> getAuthToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

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
      final response = await _dio.get(endpoint,
          queryParameters: query, options: Options(headers: headers));
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // Generic POST request
  Future<dynamic> postRequest(String endpoint,
      {dynamic data, bool requiresAuth = false}) async {
    try {
      final headers = await _getAuthHeaders(requiresAuth);
      final response =
      await _dio.post(endpoint, data: data, options: Options(headers: headers));
      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // Fetch Authorization Header if Required
  Future<Map<String, String>> _getAuthHeaders(bool requiresAuth) async {
    if (requiresAuth) {
      final token = await getAuthToken();
      if (token != null) {
        return {'Authorization': 'Bearer $token'};
      }
    }
    return {};
  }

  // Response handler
  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data ?? {};
    } else {
      throw Exception(
          'Error: ${response.statusCode} - ${response.statusMessage}');
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
          throw Exception(
              'Server error: ${error.response?.statusCode ?? "Unknown"}');
        case DioExceptionType.cancel:
          throw Exception('Request cancelled.');
        case DioExceptionType.connectionError:
          throw Exception('No Internet connection. Please check your network.');
        default:
          throw Exception('Unexpected error: ${error.message}');
      }
    } else {
      throw Exception('Unexpected error occurred. Please try again later.');
    }
  }
}


