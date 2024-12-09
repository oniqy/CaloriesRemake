import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  static String createApiUrl(String endpoint) {
    String baseUrl = 'http://192.168.1.8/dbCaloriesTracker/';
    print('URL:$baseUrl$endpoint');
    return '$baseUrl$endpoint';
  }

  Future<Response> postReq(Map<String, dynamic> data, String endpoint) async {
    final url = createApiUrl(endpoint);
    try {
      print("Attempting to post data to $url with body: $data");
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
     
      return response;
    } catch (error) {
      print('Error occurred during POST request: $error');
      rethrow;
    }
  }

  Future<Response> getReq(String endpoint,
      {Map<String, String>? params}) async {
    String url = createApiUrl(endpoint);
    if (params != null && params.isNotEmpty) {
      final queryString = Uri(queryParameters: params).query;
      url = '$url?$queryString';
    }
    try {
      final response = await http.get(Uri.parse(url));
     
      return response;
    } catch (error) {
      print('Error occurred during GET request: $error');
      rethrow;
    }
  }

  Future<http.Response> deleteReq(String endpoint,
      {Map<String, dynamic>? data}) async {
    String url = createApiUrl(endpoint);
    try {
      print("Attempting to DELETE data at $url with body: $data");

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data != null
            ? jsonEncode(data)
            : null, 
      );

     
      return response;
    } catch (error) {
      print('Error occurred during DELETE request: $error');
      rethrow;
    }
  }
}
