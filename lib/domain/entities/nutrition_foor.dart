class NutritionFoodEntity {
  int idFood;
  String foodName;
  double calories;
  double fats;
  double proteins;
  double carbs;
  String amount;

  NutritionFoodEntity({
    required this.idFood,
    required this.foodName,
    required this.calories,
    required this.fats,
    required this.proteins,
    required this.carbs,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'idFood': idFood,
      'foodName': foodName,
      'calories': calories,
      'fats': fats,
      'proteins': proteins,
      'carbs': carbs,
      'amount': amount,
    };
  }

  factory NutritionFoodEntity.fromJson(Map<String, dynamic> json) {
    return NutritionFoodEntity(
      idFood: json['IdFood'],
      foodName: json['FoodName'],
      calories: (json['Calories'] as num).toDouble(),
      fats: (json['Fats'] as num).toDouble(),
      proteins: (json['Proteins'] as num).toDouble(),
      carbs: (json['Carbs'] as num).toDouble(),
      amount: json['Amount'],
    );
  }
}
