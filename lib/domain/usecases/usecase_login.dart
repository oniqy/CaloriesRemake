import 'dart:convert';
import 'dart:math';

import 'package:calories_remake/data/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int?> loginUser(String userName, String password) async {
  const endpoint = "login";
  final data = {"username": userName, "password": password};
  try {
    print("Calling API with data: $data");
    final response = await ApiService().postReq(data, endpoint);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData is List && responseData.isNotEmpty) {
        final user = responseData[0];
        SharedPreferences prefs = await SharedPreferences.getInstance();

        final userAccountId = user["IdUser"];
        await prefs.setInt('userAccountId', userAccountId);
        await prefs.setString('UserEmail', user["UserEmail"]);
        print("Successfully logged in with data: $responseData");
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
