import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';
import 'package:calories_remake/domain/entities/nutrition_foor.dart';

Future<NutritionFoodEntity> getFoodById(int idFood) async {
  const endpoint = "getFoodById";

  try {
    final response = await ApiService()
        .getReq(endpoint, params: {'IdFood': idFood.toString()});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final data = jsonResponse['data'];

      return NutritionFoodEntity.fromJson(data);
    } else {
      print('Error fetching food by ID: ${response.statusCode}');
      throw Exception('Failed to load food info for IdFood: $idFood');
    }
  } catch (e) {
    print('Exception: $e');
    rethrow;
  }
}
