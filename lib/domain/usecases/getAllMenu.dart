import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';
import 'package:calories_remake/domain/entities/nutrition_foor.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<NutritionFoodEntity>> getAllFoodMenu() async {
  const endpoint = "getAllFoodMenu";

  try {
    final response = await ApiService().getReq(endpoint);

    print('Response data: ${response.statusCode}: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final dataList = jsonResponse['data'] as List<dynamic>;

      return dataList
          .map((item) => NutritionFoodEntity.fromJson(item))
          .toList();
    } else {
      print('Error fetching food menu: ${response.statusCode}');
      throw Exception('Failed to load food info');
    }
  } catch (e) {
    print('Exception: $e');
    rethrow;
  }
}
