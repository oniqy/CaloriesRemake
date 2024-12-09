import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';

Future<int> createNewFood(
    String foodName, double calories,double fats,double proteins,double carbs, String amount) async {
  const endpoint = "createNewFood";
  final data = {
   "FoodName": foodName,
    "Calories": calories,
    "Fats": fats,
    "Proteins": proteins,
    "Carbs": carbs,
    "Amount": amount
  };
  try {
    final response = await ApiService().postReq(data, endpoint);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData is List && responseData.isNotEmpty) {
        final user = responseData[0];
        print("Successfully create new food  with data: $responseData");
      }
    } else {
      print('Failed with status code ${response.statusCode}: ${response.body}');
    }
    return response.statusCode;
  } catch (e) {
    print('Exception: $e');
    return -1;
  }
}
