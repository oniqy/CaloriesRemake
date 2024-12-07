import 'dart:convert';

import 'package:calories_remake/data/api_service.dart';

Future<int?> deleteDailyMeal(int idDailyIn) async {
  const endpoint = "deleteDailyMeal";

  try {
    final response =
        await ApiService().deleteReq(endpoint, data: {'IdDailyIn': idDailyIn});

    print('Response data: ${response.statusCode}: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('Delete successful: ${jsonResponse['message']}');
      return response.statusCode;
    } else if (response.statusCode == 404) {
      final jsonResponse = jsonDecode(response.body);
      print('Not Found: ${jsonResponse['error']}');
      return response.statusCode;
    } else {
      print('Error deleting daily meal: ${response.statusCode}');
      return response.statusCode;
    }
  } catch (e) {
    print('Exception: $e');
    rethrow;
  }
}
