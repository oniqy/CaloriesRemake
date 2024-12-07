class UserInfoEntity {
  int userAccountId;
  double userHeight;
  double userWeight;
  String exerciseIntensity;
  String target;
  int age;

  UserInfoEntity({
    required this.userAccountId,
    required this.userHeight,
    required this.userWeight,
    required this.exerciseIntensity,
    required this.target,
    required this.age,
  });

  // Method to convert the entity to JSON format
  Map<String, dynamic> toJson() {
    return {
      'userAccountId': userAccountId,
      'userHeight': userHeight,
      'userWeight': userWeight,
      'exerciseIntensity': exerciseIntensity,
      'target': target,
      'age': age,
    };
  }

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) {
    return UserInfoEntity(
      userAccountId: json['UserAccountId'],
      userHeight:
          (json['UserHeight'] as num).toDouble(), 
      userWeight: (json['UserWidth'] as num).toDouble(),
      exerciseIntensity: json['ExerciseIntensity'],
      target: json['Target'],
      age: json['Old'],
    );
  }
}
