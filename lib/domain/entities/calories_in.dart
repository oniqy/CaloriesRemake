class CaloriesIn {
  final int idDailyIn;
  final String timeOfADay;
  final String typeOfMeal;
  final int idUserInfo;
  final int idFood;

  CaloriesIn({
    required this.idDailyIn,
    required this.timeOfADay,
    required this.typeOfMeal,
    required this.idUserInfo,
    required this.idFood,
  });

  factory CaloriesIn.fromJson(Map<String, dynamic> json) {
    return CaloriesIn(
      idDailyIn: json['IdDailyIn'],
      timeOfADay: json['TimeOfADay'],
      typeOfMeal: json['TypeOfMeal'],
      idUserInfo: json['IdUserInfo'],
      idFood: json['IdFood'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IdDailyIn': idDailyIn,
      'TimeOfADay': timeOfADay,
      'TypeOfMeal': typeOfMeal,
      'IdUserInfo': idUserInfo,
      'IdFood': idFood,
    };
  }
}
