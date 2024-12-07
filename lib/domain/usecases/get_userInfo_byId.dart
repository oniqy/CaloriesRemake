import 'dart:convert';
import 'package:calories_remake/data/api_service.dart';
import 'package:calories_remake/domain/entities/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getUserInfoById(int id) async {
  const endpoint = "getUserInfoByid";

  try {
    final response = await ApiService()
        .getReq(endpoint, params: {'UserAccountId': id.toString()});
    final responseData = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      final userInfoID = responseData["IdUserInfo"];

      await prefs.setInt('userInfoId', userInfoID);
    }

    return response.statusCode;
  } catch (e) {
    print('Exception: $e');
    return -1;
  }
}

Future<UserInfoEntity> getInfo(int id) async {
  const endpoint = "getUserInfoByid";

  try {
    final response = await ApiService()
        .getReq(endpoint, params: {'UserAccountId': id.toString()});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = data[0];
      print('Response data :    ${response.statusCode}: ${response.body}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userAccountId = user["IdUserInfo"];
      await prefs.setInt('IdUserInfo', userAccountId);
      print('MÃ THÔNG TINN :    ${userAccountId}');
      return UserInfoEntity.fromJson(data.first);
    } else {
      throw Exception('Failed to load user info');
    }
  } catch (e) {
    print('Error fetching user info: $e');
    rethrow;
  }
}
