import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';
import 'package:calories_remake/domain/entities/calories_in.dart';

Future<List<CaloriesIn>> getAllCaloriesById(int? id) async {
  const endpoint = "getAllCaloIn";

  try {
    final response = await ApiService()
        .getReq(endpoint, params: {'IdUserInfo': id.toString()});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List) {
        return jsonResponse
            .map((item) => CaloriesIn.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Invalid data format: Response is not a list.");
      }
    } else {
      print('Error fetching all calories: ${response.statusCode}');
      throw Exception('Failed to load meal info');
    }
  } catch (e) {
    print('Exception: $e');
    rethrow;
  }
}
