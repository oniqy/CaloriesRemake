import 'package:calories_remake/domain/entities/nutrition_foor.dart';
import 'package:calories_remake/domain/usecases/getAllMenu.dart';
import 'package:calories_remake/page/NutritionDetail_page.dart';
import 'package:flutter/material.dart';

import '../Language/lang.dart';

class MenuFood extends StatefulWidget {
  const MenuFood({super.key});

  @override
  State<MenuFood> createState() => _MenuFoodState();
}

class _MenuFoodState extends State<MenuFood> {
  @override
  void initState() {
    super.initState();
    getAllMenu();
  }

  List<NutritionFoodEntity> nutritionFoodEntity = [];

  List<String> foodName = [];
  List<double> kcal = [];
  List<String> amount = [];
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
        print("amout: $amount");
      });
    } catch (e) {
      print('Error fetching food menu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 40),
              child: Text(
                lang('FoodMenu', 'Menu'),
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            SizedBox(
              height: 800,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 120),
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
