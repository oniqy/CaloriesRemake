import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';

Future<int?> createAccount(
    String userName, String password, String userEmail) async {
  const endpoint = "createUserAccount";
  final data = {
    "UserName": userName,
    "Password": password,
    "UserEmail": userEmail
  };
  try {
    print("Calling API with data: $data");
    final response = await ApiService().postReq(data, endpoint);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData is List && responseData.isNotEmpty) {
        final user = responseData[0];
        print("Successfully Signup in with data: $responseData");
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
