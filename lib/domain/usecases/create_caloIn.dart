import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';

Future<int?> CreateCaloriesIn(
    String TimeOfADay, String TypeOfMeal, int IdUserInfo, int IdFood) async {
  const endpoint = "createCaloriesIn";
  final data = {
    "TimeOfADay": TimeOfADay,
    "TypeOfMeal": TypeOfMeal,
    "IdUserInfo": IdUserInfo,
    "IdFood": IdFood
  };
  try {
    print("Calling API with data: $data");
    final response = await ApiService().postReq(data, endpoint);
    if (response.statusCode != 200) {
      jsonDecode(response.body);
    } else {}
    return response.statusCode;
  } catch (e) {
    print('Exception: $e');
    return -1;
  }
}
