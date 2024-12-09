import 'dart:convert';

import 'package:calories_remake/data/api_service.dart';
import 'package:calories_remake/domain/entities/nutrition_foor.dart';

Future<List<NutritionFoodEntity>?> searchByFoodName(String foodName) async {
  const endpoint = "searchByFoodName";

  try {
    final response = await ApiService().getReq(endpoint, params: {
      'FoodName': foodName,
    });

    if (response.statusCode == 200) {
      // Giải mã JSON từ response
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      // Truy cập danh sách trong trường "data"
      if (jsonData["status"] == "success" && jsonData["data"] is List) {
        final List<dynamic> data = jsonData["data"];
        return data.map((item) => NutritionFoodEntity.fromJson(item)).toList();
      } else {
        print('Unexpected JSON structure: ${response.body}');
        return null;
      }
    } else {
      print('Failed to fetch data: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
