import 'dart:convert';

import 'package:calories_remake/Witget/calendar.dart';
import 'package:calories_remake/domain/entities/calories_in.dart';
import 'package:calories_remake/domain/entities/nutrition_foor.dart';
import 'package:calories_remake/domain/entities/user_info.dart';
import 'package:calories_remake/domain/usecases/delete_daily_meal.dart';
import 'package:calories_remake/domain/usecases/get_all_caloIn_by_day.dart';
import 'package:calories_remake/domain/usecases/get_food_by_id.dart';
import 'package:calories_remake/domain/usecases/get_userInfo_byId.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:percent_indicator/linear_percent_indicator.dart';

import '../language/lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> foodName = [];
  List<double> kcal = [];
  List<int> FoodIdInDay = [];
  List<int> idCaloIn = [];
  String? email;
  double? chieuCao;
  double? canNang;
  double? bmi;
  double? bmr;
  late UserInfoEntity userInfoEntity;
  double? TDEE;
  late NutritionFoodEntity nutritionFoodEntity;
  late List<NutritionFoodEntity> nutritionFoodEntityList = [];

  DateTime realDate = DateTime.now();
  bool isLoading = true;
  List<CaloriesIn> caloriesDaily = [];
  String formattedDate = "";
  void takeREalDate() {
    DateTime realDate = DateTime.now();
    formattedDate = "${realDate.day}-${realDate.month}-${realDate.year}";
  }

  @override
  void initState() {
    super.initState();
    getAllCaloIn();
    getemail();
    getInfoUser();
    takeREalDate();
     _refreshData();
    
  }

  double? proteins;
  double? carbs;
  double? fats;
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      getAllCaloIn();
    });
  }

  void getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('UserEmail');
    });
  }

  void getInfoUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userAccountId = prefs.getInt('userAccountId');
    userInfoEntity = await getInfo(userAccountId!);
    if (userInfoEntity == null) {
      print('Error: userInfoEntity is null');
      setState(() {
        isLoading = false;
      });
      return;
    }
    double canNang = userInfoEntity.userWeight;
    double chieuCao = userInfoEntity.userHeight;
    int age = userInfoEntity.age;
    double tinhBMR =
        88.362 + (13.397 * canNang) + (4.799 * chieuCao) - (5.677 * age);
    String formattedBmr = tinhBMR.toStringAsFixed(1);
    setState(() {
      bmr = double.parse(formattedBmr);
      if (userInfoEntity.exerciseIntensity == 'khongTap') {
        TDEE = double.parse((bmr! * 1.2).toStringAsFixed(1));
      } else if (userInfoEntity.exerciseIntensity == 'It') {
        TDEE = double.parse((bmr! * 1.375).toStringAsFixed(1));
      } else if (userInfoEntity.exerciseIntensity == 'Vua') {
        TDEE = double.parse((bmr! * 1.55).toStringAsFixed(1));
      } else {
        TDEE = double.parse((bmr! * 1.725).toStringAsFixed(1));
      }
    });
    double saveTdee = TDEE!;
    await prefs.setDouble('TDEE', saveTdee);
    await prefs.setString('target', userInfoEntity.target);
    setState(() {
      if (userInfoEntity.target == "GiamCan") {
        proteins = double.parse((TDEE! * 0.35 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE! * 0.35 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE! * 0.30 / 9).toStringAsFixed(1));
      } else if (userInfoEntity.target == "DuyTri") {
        proteins = double.parse((TDEE! * 0.30 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE! * 0.50 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE! * 0.20 / 9).toStringAsFixed(1));
      } else if (userInfoEntity.target == "TangCan") {
        proteins = double.parse((TDEE! * 0.25 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE! * 0.55 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE! * 0.20 / 9).toStringAsFixed(1));
      } else {
        proteins = double.parse((TDEE! * 0.30 / 4).toStringAsFixed(1));
        carbs = double.parse((TDEE! * 0.50 / 4).toStringAsFixed(1));
        fats = double.parse((TDEE! * 0.20 / 9).toStringAsFixed(1));
      }
    });
  }

  double totalProteins = 0.0;
  double totalFats = 0.0;
  double totalCarbs = 0.0;
  double totalCalories = 0.0;
  void getAllCaloIn() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? IdUserInfo = prefs.getInt('IdUserInfo');

    if (IdUserInfo == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final fetchedData = await getAllCaloInByDay(formattedDate, IdUserInfo);
    totalProteins = 0.0;
    totalFats = 0.0;
    totalCarbs = 0.0;
    totalCalories = 0.0;
    if (fetchedData != null) {
      caloriesDaily = fetchedData;

      idCaloIn = fetchedData.map((item) => item.idDailyIn).toList();
      FoodIdInDay = fetchedData.map((item) => item.idFood).toList();
      final foodResults = await Future.wait(
        FoodIdInDay.map((id) => getFoodById(id)),
      );
      setState(() {
        foodName.clear();
        kcal.clear();
        for (var food in foodResults) {
          nutritionFoodEntityList.add(food);
          nutritionFoodEntity = food;
          foodName.add(nutritionFoodEntity.foodName);
          kcal.add(nutritionFoodEntity.calories);
          totalProteins += nutritionFoodEntity.proteins;
          totalFats += nutritionFoodEntity.fats;
          totalCarbs += nutritionFoodEntity.carbs;
          totalCalories += nutritionFoodEntity.calories;
        }
        checkChiSo();
        isLoading = false;
        print("Đây là nutritionFoodEntityList : $nutritionFoodEntityList");
        print("Đây là FoodIdInDay : $FoodIdInDay");
      });
    } else {
      setState(() {
        FoodIdInDay = [];
        foodName.clear();
        kcal.clear();
        isLoading = false;
      });
    }
  }

  void checkChiSo() {
    if (totalProteins > (proteins ?? 2000) ||
        totalCalories > (TDEE ?? 2000) ||
        totalFats > (fats ?? 2000) ||
        totalCarbs > (carbs ?? 2000)) {
      popup();
    }
  }

  void deleteDailyFood(int id) async {
    int? i = await deleteDailyMeal(idCaloIn[id]);
    if (i == 200) {
      getAllCaloIn();
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> popup() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFD479FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Hãy kiểm soát chế độ ăn của bạn",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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

  Widget getRecentMeal() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (FoodIdInDay.isEmpty) {
      return Center(
        child: Text(
          "Hãy thêm món ăn trong ngày nhé",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: FoodIdInDay.length,
        itemBuilder: (context, index) {
          double dragOffset = 0;
          return StatefulBuilder(
            builder: (context, setState) {
              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    dragOffset =
                        (dragOffset + details.delta.dx).clamp(-100.0, 0.0);
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (dragOffset <= -100.0) {
                    setState(() {
                      dragOffset = -100.0;
                    });
                  } else {
                    setState(() {
                      dragOffset = 0.0;
                    });
                  }
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              deleteDailyFood(index);
                              FoodIdInDay.removeAt(index);
                              foodName.removeAt(index);
                              kcal.removeAt(index);
                              nutritionFoodEntityList.removeAt(index);
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              margin: const EdgeInsets.only(top: 10, right: 5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                lang("dele", "Delete"),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(dragOffset, 0),
                      child: Container(
                        height: 53,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0.2, 0.2),
                              blurRadius: 2.0,
                              spreadRadius: 0.2,
                            )
                          ],
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 34,
                                width: 34,
                                margin: const EdgeInsets.only(right: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/huh_cat.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                '${foodName[index]} ',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${kcal[index]} calo',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 55,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$email",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 34,
                          width: 34,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/huh_cat.jpg',
                                fit: BoxFit.fill,
                              )),
                        )
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
                      getAllCaloIn();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD479FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Ngày đã chọn: $formattedDate",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          elevation: 0, // Tắt hiệu ứng nổi
                          backgroundColor: Colors.transparent,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 105, right: 105),
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color.fromRGBO(188, 124, 237, 0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Color(0xFFD479FF),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 199, 99, 245),
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 25, left: 25),
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(188, 124, 237, 0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang("headingHome", "Calculate Calories"),
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                                height: 180,
                                width: 180,
                                child: CustomPaint(
                                  painter: ShapePainter(
                                      process: totalCalories,
                                      maxValue: TDEE ?? 0),
                                  child: Container(),
                                )),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xFFF5E3FF)),
                            ),
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$totalCalories/\n$TDEE",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Calories',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          animation: true,
                          animationDuration: 1500,
                          lineHeight: 18,
                          leading: Text(
                            "Proteins",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          percent: (totalProteins > (proteins ?? 1))
                              ? 1
                              : totalProteins / (proteins ?? 1),
                          center: Text(
                            "$totalProteins/$proteins",
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          progressColor: const Color(0xFFD479FF),
                          backgroundColor: const Color(0xFFE5CAFF),
                          barRadius: const Radius.circular(10),
                        ),
                        LinearPercentIndicator(
                          animation: true,
                          animationDuration: 1500,
                          lineHeight: 18,
                          leading: Text("Carbs",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          percent: (totalCarbs > (carbs ?? 1))
                              ? 1
                              : totalCarbs / (carbs ?? 1),
                          center: Text(
                            "$totalCarbs/$carbs",
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          progressColor: const Color(0xFFD479FF),
                          backgroundColor: const Color(0xFFE5CAFF),
                          barRadius: const Radius.circular(10),
                        ),
                        LinearPercentIndicator(
                          animation: true,
                          animationDuration: 1500,
                          lineHeight: 18,
                          leading: Text("Fats",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          percent: (totalFats > (fats ?? 1))
                              ? 1
                              : totalFats / (fats ?? 1),
                          center: Text(
                            "$totalFats/$fats",
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          progressColor: const Color(0xFFD479FF),
                          backgroundColor: const Color(0xFFE5CAFF),
                          barRadius: const Radius.circular(10),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 25, top: 30),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          lang('heading2Home', 'Recent Meal'),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFFD479FF)),
                        ))),
                Container(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    height: 300,
                    child: getRecentMeal()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double process;
  final double maxValue;

  ShapePainter({required this.process, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Giới hạn giá trị process không vượt quá maxValue
    double adjustedProcess = process > maxValue ? maxValue : process;

    var paintBk = Paint()
      ..strokeWidth = 15
      ..color = const Color(0xFFE5CAFF)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Vẽ background arc
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      3 * math.pi / 4,
      6 * math.pi / 4,
      false,
      paintBk,
    );

    var paintProcess = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFD479FF)
      ..strokeWidth = 15;

    // Tính toán phần trăm và vẽ tiến trình
    double percentage = 3 * math.pi / 2 * (adjustedProcess / maxValue);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      3 * math.pi / 4,
      percentage,
      false,
      paintProcess,
    );

    // Tính toán vị trí của dot
    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double position = 3 * math.pi / 4 + percentage;
    double x = centerX + radius * math.cos(position);
    double y = centerY + radius * math.sin(position);

    // Vẽ dot
    var dot = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(x, y), 12, dot);

    // Vẽ text cho giá trị hiện tại
    const textStyle = TextStyle(
      color: Color(0xFFD479FF),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: '${adjustedProcess.toInt()} cal',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );

    // Vẽ text cho maxValue (TDEE)
    const maxTextStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
    final maxTextSpan = TextSpan(
      text: 'TDEE: ${maxValue.toInt()} cal',
      style: maxTextStyle,
    );
    final maxTextPainter = TextPainter(
      text: maxTextSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    maxTextPainter.layout();
    maxTextPainter.paint(
      canvas,
      Offset(
        (size.width - maxTextPainter.width) / 2,
        (size.height / 2) + textPainter.height + 8, // Đặt dưới giá trị process
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
