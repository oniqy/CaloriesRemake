import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';
import 'package:calories_remake/domain/entities/calories_in.dart';
Future<List<CaloriesIn>?> getAllCaloInByDay(String timeOfDay, int idUserInfo) async {
  const endpoint = "getAllCaloInByDay";

  try {
    final response = await ApiService().getReq(endpoint, params: {
      'TimeOfADay': timeOfDay,
      'IdUserInfo': idUserInfo.toString(),
    });


    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => CaloriesIn.fromJson(item)).toList();
    } else {
      print('Failed to fetch data: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
