import 'package:calories_remake/domain/entities/nutrition_foor.dart';
import 'package:calories_remake/domain/usecases/create_new_food.dart';
import 'package:calories_remake/domain/usecases/getAllMenu.dart';
import 'package:calories_remake/domain/usecases/search_food.dart';
import 'package:calories_remake/page/NutritionDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/lang.dart';

class MenuFood extends StatefulWidget {
  const MenuFood({super.key});

  @override
  State<MenuFood> createState() => _MenuFoodState();
}

class _MenuFoodState extends State<MenuFood> {
  List<NutritionFoodEntity> nutritionFoodEntity = [];
  List<NutritionFoodEntity> filteredFoodEntity = [];

  List<String> foodName = [];
  List<double> kcal = [];
  List<String> amount = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _searchFocused = false;

  @override
  void initState() {
    super.initState();

    getAllMenu();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void searchFood() async {
    FocusScope.of(context).unfocus();
    String searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      getAllMenu();
    } else {
      final fetchedData =
          await searchByFoodName(_searchController.text.toLowerCase());
      setState(() {
        nutritionFoodEntity = fetchedData!;
        foodName.clear();
        kcal.clear();
        amount.clear();
        for (var item in fetchedData) {
          foodName.add(item.foodName);
          kcal.add(item.calories);
          amount.add(item.amount);
        }
      });
    }
  }

  void getAllMenu() async {
    try {
      final fetchedData = await getAllFoodMenu();
      setState(() {
        nutritionFoodEntity = fetchedData;

        for (var item in fetchedData) {
          foodName.add(item.foodName);
          kcal.add(item.calories);
          amount.add(item.amount);
        }
      });
    } catch (e) {
      print('Error fetching food menu: $e');
    }
  }

  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool issuc = false;
  void showDialogNewFood(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.create),
              SizedBox(
                width: 5,
              ),
              Text(
                'Add Food Nutrition',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _foodNameController,
                    decoration: InputDecoration(
                      labelText: 'Food Name',
                      border: OutlineInputBorder(),
                      fillColor: Theme.of(context).colorScheme.primary,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Food name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _caloriesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Calories',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Calories is required';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _fatsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Fats',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fats is required';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _proteinsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Proteins',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Proteins is required';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _carbsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Carbs',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Carbs is required';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Amount is required';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  int result = await createNewFood(
                    _foodNameController.text,
                    double.tryParse(_caloriesController.text)!,
                    double.tryParse(_fatsController.text)!,
                    double.tryParse(_proteinsController.text)!,
                    double.tryParse(_carbsController.text)!,
                    _amountController.text,
                  );
                  if (result == 200) {
                    _foodNameController.clear();
                    _amountController.clear();
                    _caloriesController.clear();
                    _carbsController.clear();
                    _fatsController.clear();
                    _proteinsController.clear();
                    Navigator.pop(context);
                    getAllMenu();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFD99BF5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      lang('FoodMenu', 'Menu'),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(right: 16, top: 40),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        issuc = false;
                      });
                      showDialogNewFood(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5CAFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.fastfood_rounded,
                        color: Color(0xFF5C0187),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outline,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        hintText: lang('Search food...', 'Tìm kiếm món ăn...'),
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    searchFood();
                    FocusScope.of(context).unfocus();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFD99BF5),
                    disabledBackgroundColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.12),
                    animationDuration: const Duration(seconds: 1),
                    minimumSize: const Size(80, 47),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    lang('searchBut', 'Search'),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 800,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 180),
                child: ListView.builder(
                    itemCount: nutritionFoodEntity.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NutritionDetail_page(
                                        nutritionFoodEntity:
                                            nutritionFoodEntity[index],
                                      )));
                        },
                        child: Container(
                            height: 60,
                            margin: const EdgeInsets.all(6.5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 2.0,
                                    spreadRadius: 0.5)
                              ],
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'assets/huh_cat.jpg',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(foodName[index],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "${amount[index]} - ${kcal[index]} kcal",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFD99BF5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.add,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                ),
                              ]),
                            )),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
