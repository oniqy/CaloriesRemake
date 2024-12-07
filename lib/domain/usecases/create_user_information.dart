import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int?> createUserInfo(int idUserInfo, double userHeight, double userWidth, String exerciseIntensity, String target, int age) async {
  const endpoint = "createInfoUser";
  
  final data = {
    "UserAccountId": idUserInfo,
    "UserHeight": userHeight,
    "UserWidth": userWidth,
    "ExerciseIntensity": exerciseIntensity,
    "Target": target,
    "Old": age
  };

  try {
    print("Calling API with data: $data");

    final response = await ApiService().postReq(data, endpoint);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData is Map && responseData.containsKey("IdUser")) {
        final userAccountId = responseData["IdUser"];
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userAccountId', userAccountId);
        
      } else {
        print("Unexpected response format: $responseData");
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
