import 'package:calories_remake/Witget/calendar.dart';
import 'package:calories_remake/domain/entities/nutrition_foor.dart';
import 'package:calories_remake/domain/usecases/create_caloIn.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../language/lang.dart';
import '../Witget/Indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutritionDetail_page extends StatefulWidget {
  final NutritionFoodEntity nutritionFoodEntity;
  NutritionDetail_page({required this.nutritionFoodEntity, super.key});

  @override
  State<NutritionDetail_page> createState() => _NutritionDetail_pageState();
}

class _NutritionDetail_pageState extends State<NutritionDetail_page> {
  double? proteins;
  double? carbs;
  double? fats;
  double? protein;
  double? carb;
  double? fat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count();
    takeREalDate();
  }

  void count() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? TDEE = prefs.getDouble('TDEE');
    String? target = prefs.getString("target");
    setState(() {
      if (target == "GiamCan") {
        proteins = double.parse((TDEE! * 0.4 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE * 0.4 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE * 0.3 / 9).toStringAsFixed(1));

        protein = double.parse((widget.nutritionFoodEntity.proteins / proteins!)
            .toStringAsFixed(2));
        carb = double.parse(
            (widget.nutritionFoodEntity.carbs / carbs!).toStringAsFixed(2));
        fat = double.parse(
            (widget.nutritionFoodEntity.fats / fats!).toStringAsFixed(2));
      } else if (target == "DuyTri") {
        proteins = double.parse((TDEE! * 0.4 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE * 0.3 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE * 0.3 / 9).toStringAsFixed(1));

        protein = double.parse((widget.nutritionFoodEntity.proteins / proteins!)
            .toStringAsFixed(2));
        carb = double.parse(
            (widget.nutritionFoodEntity.carbs / carbs!).toStringAsFixed(2));
        fat = double.parse(
            (widget.nutritionFoodEntity.fats / fats!).toStringAsFixed(2));
      } else if (target == "TangCan") {
        proteins = double.parse((TDEE! * 0.35 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE * 0.5 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE * 0.25 / 9).toStringAsFixed(1));

        protein = double.parse((widget.nutritionFoodEntity.proteins / proteins!)
            .toStringAsFixed(2));
        carb = double.parse(
            (widget.nutritionFoodEntity.carbs / carbs!).toStringAsFixed(2));
        fat = double.parse(
            (widget.nutritionFoodEntity.fats / fats!).toStringAsFixed(2));
      } else {
        proteins = double.parse((TDEE! * 0.4 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE * 0.3 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE * 0.3 / 9).toStringAsFixed(1));
        protein = double.parse((widget.nutritionFoodEntity.proteins / proteins!)
            .toStringAsFixed(2));
        carb = double.parse(
            (widget.nutritionFoodEntity.carbs / carbs!).toStringAsFixed(2));
        fat = double.parse(
            (widget.nutritionFoodEntity.fats / fats!).toStringAsFixed(2));
      }
    });
  }

  String formattedDate = "";
  void takeREalDate() {
    DateTime realDate = DateTime.now();
    formattedDate = "${realDate.day}-${realDate.month}-${realDate.year}";
  }

  void createDailyCalo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? IdUserInfo = prefs.getInt('IdUserInfo');
    int? i = await CreateCaloriesIn(
        formattedDate, 'Meal', IdUserInfo!, widget.nutritionFoodEntity.idFood);
    if (i == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary, 
              borderRadius: BorderRadius.circular(10), 
            ),
            child: Text(
              "Bạn đã thêm ${widget.nutritionFoodEntity.foodName} vào ngày $formattedDate",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25, right: 25, top: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 2.0,
                    spreadRadius: 0.3)
              ],
              color: Theme.of(context).colorScheme.onSecondary),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFE5CAFF),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF5C0187),
                        ),
                      ),
                    )),
                Text(
                  lang("AppBarDetailFood", "Nutrition Details"),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                Container(
                    height: 30,
                    width: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFE5CAFF),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.fastfood_rounded,
                          color: Color(0xFF5C0187),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        leading: Container(width: 0.0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${widget.nutritionFoodEntity.foodName}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Container(
                      height: 200,
                      margin:
                          const EdgeInsets.only(left: 25, right: 25, top: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text("${widget.nutritionFoodEntity.calories} calo"),
                          PieChart(
                            swapAnimationDuration:
                                const Duration(milliseconds: 1500),
                            swapAnimationCurve: Curves.easeInOut,
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: widget.nutritionFoodEntity.carbs,
                                  color: const Color(0xFFFB7E93),
                                  radius: 60,
                                ),
                                PieChartSectionData(
                                  value: widget.nutritionFoodEntity.fats,
                                  color: const Color(0xFF6CEA90),
                                  radius: 60,
                                ),
                                PieChartSectionData(
                                  value: widget.nutritionFoodEntity.proteins,
                                  color: const Color(0xFFF3B838),
                                  radius: 60,
                                ),
                              ],
                              sectionsSpace: 3,
                              centerSpaceRadius: 40,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Indicator(
                          color: Color(0xFFFB7E93),
                          text: 'Carbs',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xFF6CEA90),
                          text: 'Fats',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xFFF3B838),
                          text: 'Proteins',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      lang("targetDaily", 'target'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0.5, 0.5),
                                blurRadius: 2.0,
                                spreadRadius: 0.3)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Carbs',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            const SizedBox(
                              height: 5,
                            ),
                            Stack(
                              children: [
                                LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1500,
                                  lineHeight: 18,
                                  percent: (carb) ?? 1,
                                  progressColor: const Color(0xFFFB7E93),
                                  backgroundColor: const Color(0xFFE7E7E7),
                                  barRadius: const Radius.circular(10),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "${widget.nutritionFoodEntity.carbs}/${carbs}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Fats',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            const SizedBox(
                              height: 5,
                            ),
                            Stack(
                              children: [
                                LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1500,
                                  lineHeight: 18,
                                  percent: (fat) ?? 1,
                                  progressColor: const Color(0xFF6CEA90),
                                  backgroundColor: const Color(0xFFE7E7E7),
                                  barRadius: const Radius.circular(10),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "${widget.nutritionFoodEntity.fats}/${fats}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Proteins',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Stack(
                              children: [
                                LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1500,
                                  lineHeight: 18,
                                  percent: (protein) ?? 1,
                                  progressColor: const Color(0xFFF3B838),
                                  backgroundColor: const Color(0xFFE7E7E7),
                                  barRadius: const Radius.circular(10),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        "${widget.nutritionFoodEntity.proteins}/${proteins}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? selectedDate =
                            await CalendarPopup.showCalendar(context);

                        if (selectedDate != null) {
                          setState(() {
                            formattedDate =
                                "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Ngày đã chọn: $formattedDate",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                ),
                              ),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 35,
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 105, right: 105),
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              formattedDate,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          lang('exchangeCalo', 'ExchangeCalories') + "calo",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_right_alt_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 35,
                        )
                      ],
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
            Positioned(
              left: 25,
              right: 25,
              bottom: 15,
              child: GestureDetector(
                onTap: () {
                  createDailyCalo();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFE5CAFF),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 2.0,
                            spreadRadius: 0.3)
                      ]),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lang('UpdateDailyMenu', 'UpdateDailyMenu'),
                        style: const TextStyle(color: Color(0xFF5C0187)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.add_sharp,
                        color: Color(0xFF5C0187),
                        size: 25,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
