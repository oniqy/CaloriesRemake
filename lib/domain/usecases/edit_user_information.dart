import 'package:calories_remake/data/api_service.dart';

Future<int?> editUSerInfo( int userAccountId, double userHeight, double userWidth,
    String exerciseIntensity, String target, int age) async {
  const endpoint = "editUserInfo";

  final data = {
    "UserAccountId": userAccountId,
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
      print('status code ${response.statusCode}: ${response.body}');
      return response.statusCode;
    } else {
      print('Failed with status code ${response.statusCode}: ${response.body}');
    }

    return response.statusCode;
  } catch (e) {
    print('Exception: $e');
    return -1;
  }
}
