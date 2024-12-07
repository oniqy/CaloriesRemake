import 'package:calories_remake/Language/lang.dart';
import 'package:calories_remake/domain/entities/calories_in.dart';
import 'package:calories_remake/domain/entities/nutrition_foor.dart';
import 'package:calories_remake/domain/entities/user_info.dart';
import 'package:calories_remake/domain/usecases/get_all_caloriesin.dart';
import 'package:calories_remake/domain/usecases/get_food_by_id.dart';
import 'package:calories_remake/domain/usecases/get_userInfo_byId.dart';
import 'package:calories_remake/page/BMI_Edit.dart';
import 'package:calories_remake/page/BMR_Edit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartPage extends StatefulWidget {
  ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  int height = 173;
  int weight = 62;
  int calo = 2010;
  bool showAvg = false;
  bool showAvg2 = false;
  double? chieuCao;
  double? canNang;
  double? bmi;
  double? bmr;
  Map<String, double> globalWeekdayCalories = {};

  late UserInfoEntity userInfoEntity;
  @override
  void initState() {
    super.initState();
    getInfoUser();
    Future.delayed(const Duration(seconds: 2));
    setState(() {
      getDataForChart();
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      getDataForChart();
    });
  }

  void getInfoUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userAccountId = prefs.getInt('userAccountId');
    userInfoEntity = await getInfo(userAccountId!);
    int age = userInfoEntity.age;

    setState(() {
      chieuCao = userInfoEntity.userHeight;
      canNang = userInfoEntity.userWeight;
      double tinhBMR =
          88.362 + (13.397 * canNang!) + (4.799 * chieuCao!) - (5.677 * age);
      String formattedBmr = tinhBMR.toStringAsFixed(1);
      bmr = double.parse(formattedBmr);
    });

    tinhBMI(canNang!, chieuCao!);
  }

  void tinhBMI(double w, double h) {
    setState(() {
      double h2 = h / 100;
      double cal = w / (h2 * h2);
      String formattedBmr = cal.toStringAsFixed(1);
      bmi = double.parse(formattedBmr);
    });
  }

  List<int> FoodIdInDay = [];
  List<String> getDate = [];
  dynamic listData;
  List<double> kcal = [];
  late NutritionFoodEntity nutritionFoodEntity;

  void getDataForChart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? idUserInfo = prefs.getInt('IdUserInfo');

      if (idUserInfo == null) {
        print('Error: IdUserInfo is null');
        return;
      }
      final List<CaloriesIn> caloriesIn = await getAllCaloriesById(idUserInfo);
      FoodIdInDay = caloriesIn.map((item) => item.idFood).toList();
      getDate = caloriesIn.map((item) => item.timeOfADay).toList();
      for (int i = 0; i < FoodIdInDay.length; i++) {}
      final foodResults = await Future.wait(
        FoodIdInDay.map((id) => getFoodById(id)),
      );
      for (var food in foodResults) {
        kcal.add(food.calories);
      }

      Map<String, double> result = calculateCaloriesByWeekday(getDate, kcal);
      globalWeekdayCalories = result;
      result.forEach((weekday, totalCalories) {});
    } catch (e) {
      print('Error in getDataForChart: $e');
    }
  }

  int getWeekOfYear(DateTime date) {
    //lấy ngyaf hiện tại để tính tuần trong năm
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - DateTime.monday;
    final startOfFirstWeek = firstDayOfYear.subtract(
        Duration(days: daysOffset)); //điều chỉnh để lấy được thứ 2 của tuần đó

    if (date.isBefore(startOfFirstWeek)) return 1;

    final difference = date.difference(startOfFirstWeek).inDays;
    return (difference ~/ 7) + 1;
  }

  Map<String, double> calculateCaloriesByWeekday(
      List<String> dates, List<double> calories) {
    Map<String, double> weekdayCalories = {
      'Monday': 0.0,
      'Tuesday': 0.0,
      'Wednesday': 0.0,
      'Thursday': 0.0,
      'Friday': 0.0,
      'Saturday': 0.0,
      'Sunday': 0.0,
    };
    final currentWeek = getWeekOfYear(DateTime.now());
    final currentYear = DateTime.now().year;
    for (int i = 0; i < dates.length; i++) {
      String date = dates[i];
      double calorie = calories[i];

      try {
        DateTime parsedDate = parseCustomDate(date);
        int weekOfYear = getWeekOfYear(parsedDate);
        if (weekOfYear == currentWeek && parsedDate.year == currentYear) {
          String weekday = _getWeekdayName(parsedDate.weekday);
          weekdayCalories[weekday] = weekdayCalories[weekday]! + calorie;
        }
      } catch (e) {
        print('Lỗi khi parse ngày: $date, lỗi: $e');
      }
    }

    return weekdayCalories;
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        throw Exception('Invalid weekday number: $weekday');
    }
  }

  DateTime parseCustomDate(String date) {
    final parts = date.split('-');
    if (parts.length != 3) {
      throw FormatException('Invalid date format: $date');
    }
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 40),
                child: Text(
                  lang('headingChart', 'Chart'),
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang('subHeading1', 'BMI'),
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BMI_Edit()));
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              size: 35,
                            ))
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Theme.of(context).colorScheme.onSecondary,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 2.2,
                            spreadRadius: 0.7,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'BMI',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '$bmi',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                  color: Color(0xFFD479FF)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Divider(
                                height: 2,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        lang('h', 'Height'),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      Text('$chieuCao cm',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(lang('w', 'Weight'),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)),
                                      Text('$canNang kg',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang('subHeading2', 'BMR'),
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BMR_Edit(
                                            userInfoEntity: userInfoEntity,
                                          )));
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              size: 35,
                            ))
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Theme.of(context).colorScheme.onSecondary,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 2.0,
                            spreadRadius: 0.7,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                'BMR',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 25, right: 20),
                              width: 1,
                              height: 100,
                              color: Colors.grey.shade700,
                            ),
                            Text(
                              '$bmr/day',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                                color: Color(0xFFD479FF),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 25, right: 25, bottom: 7),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD479FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    lang('chartCalo', 'Calo'),
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  )),
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.30,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 12,
                        top: 24,
                        bottom: 12,
                      ),
                      child: LineChart(
                        CaloInDataWeek(globalWeekdayCalories),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget bottomTitleWidgetsWeek(double value, TitleMeta meta) {
  const style =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey);

  // Map giá trị trục X thành tên thứ
  Map<int, String> indexToWeekday = {
    0: 'Th2',
    2: 'Th3',
    4: 'Th4',
    6: 'Th5',
    8: 'Th6',
    10: 'Th7',
    12: 'CN',
  };

  Widget text;
  if (indexToWeekday.containsKey(value.toInt())) {
    text = Text(indexToWeekday[value.toInt()]!, style: style);
  } else {
    text = const Text('', style: style);
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Color(0xFFD479FF)
  );

  String text = '';
  if (value % 500 == 0) {
    text = value.toInt().toString();
  }

  if (text.isEmpty) {
    return Container();
  }

  return Text(
    text,
    style: style,
    textAlign: TextAlign.left,
  );
}

LineChartData CaloInDataWeek(Map<String, double> weekdayCalories) {
  Map<String, int> weekdayToIndex = {
    'Monday': 0,
    'Tuesday': 2,
    'Wednesday': 4,
    'Thursday': 6,
    'Friday': 8,
    'Saturday': 10,
    'Sunday': 12,
  };
  List<Color> gradientColors = [
    const Color(0xFF6CEA90),
    const Color(0xFF6CEA90),
  ];
  List<FlSpot> spots = weekdayCalories.entries.map((entry) {
    int x = weekdayToIndex[entry.key]!;
    double y = entry.value;
    return FlSpot(x.toDouble(), y);
  }).toList();
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 500,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Color(0xFF8915E4),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Color(0xFF8915E4),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) => bottomTitleWidgetsWeek(value, meta),
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 52,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 12,
    minY: 0,
    maxY: 4000,
    lineBarsData: [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (FlSpot spot, double percent, LineChartBarData barData,
              int index) {
            return ValueDotPainter();
          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ),
    ],
  );
}

// Widget bottomTitleWidgetsMonth(double value, TitleMeta meta) {
//   const style =
//       TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey);
//   Widget text;
//   switch (value.toInt()) {
//     case 0:
//       text = const Text('W1', style: style);
//       break;
//     case 4:
//       text = const Text('W2', style: style);
//       break;
//     case 8:
//       text = const Text('W3', style: style);
//       break;
//     case 12:
//       text = const Text('W4', style: style);
//       break;
//     default:
//       text = const Text('', style: style);
//       break;
//   }
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: text,
//   );
// }

// LineChartData CaloOutDataYear() {
//   List<Color> gradientColors = [
//     Colors.red,
//     Colors.red,
//   ];
//   return LineChartData(
//     gridData: FlGridData(
//       show: true,
//       drawVerticalLine: true,
//       horizontalInterval: 1,
//       verticalInterval: 1,
//       getDrawingHorizontalLine: (value) {
//         return const FlLine(
//           color: Color(0xFF8915E4),
//           strokeWidth: 1,
//         );
//       },
//       getDrawingVerticalLine: (value) {
//         return const FlLine(
//           color: Color(0xFF8915E4),
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: const FlTitlesData(
//       show: true,
//       rightTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       topTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           interval: 1,
//           getTitlesWidget: bottomTitleWidgetsYear,
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           interval: 1,
//           getTitlesWidget: leftTitleWidgets,
//           reservedSize: 52,
//         ),
//       ),
//     ),
//     borderData: FlBorderData(
//       show: true,
//       border: Border.all(color: const Color(0xff37434d)),
//     ),
//     minX: 0,
//     maxX: 12,
//     minY: 0,
//     maxY: 12,
//     lineBarsData: [
//       LineChartBarData(
//         spots: const [
//           FlSpot(1, 1),
//           FlSpot(2, 3),
//           FlSpot(3, 1),
//           FlSpot(4, 2),
//           FlSpot(5, 6),
//           FlSpot(6, 5),
//           FlSpot(7, 4),
//           FlSpot(8, 3),
//           FlSpot(9, 1.1),
//           FlSpot(10, 2),
//           FlSpot(11, 9),
//           FlSpot(12, 9),
//         ],
//         isCurved: true,
//         gradient: LinearGradient(
//           colors: gradientColors,
//         ),
//         barWidth: 5,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: true,
//           getDotPainter: (FlSpot spot, double percent, LineChartBarData barData,
//               int index) {
//             return ValueDotPainter();
//           },
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors:
//                 gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// LineChartData CaloInDataMonth() {
//   List<Color> gradientColors = [
//     const Color(0xFF6CEA90),
//     const Color(0xFF6CEA90),
//   ];
//   return LineChartData(
//     gridData: FlGridData(
//       show: true,
//       drawVerticalLine: true,
//       horizontalInterval: 1,
//       verticalInterval: 1,
//       getDrawingHorizontalLine: (value) {
//         return const FlLine(
//           color: Color(0xFF8915E4),
//           strokeWidth: 1,
//         );
//       },
//       getDrawingVerticalLine: (value) {
//         return const FlLine(
//           color: Color(0xFF8915E4),
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: const FlTitlesData(
//       show: true,
//       rightTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       topTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           interval: 1,
//           getTitlesWidget: bottomTitleWidgetsMonth,
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           interval: 1,
//           getTitlesWidget: leftTitleWidgets,
//           reservedSize: 52,
//         ),
//       ),
//     ),
//     borderData: FlBorderData(
//       show: true,
//       border: Border.all(color: const Color(0xff37434d)),
//     ),
//     minX: 0,
//     maxX: 12,
//     minY: 0,
//     maxY: 12,
//     lineBarsData: [
//       LineChartBarData(
//         spots: const [
//           FlSpot(0, 3),
//           FlSpot(4, 2),
//           FlSpot(8, 5),
//           FlSpot(12, 3.1),
//         ],
//         isCurved: true,
//         gradient: LinearGradient(
//           colors: gradientColors,
//         ),
//         barWidth: 5,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: true,
//           getDotPainter: (FlSpot spot, double percent, LineChartBarData barData,
//               int index) {
//             return ValueDotPainter();
//           },
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors:
//                 gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// LineChartData CaloOutDataMonth() {
//   List<Color> gradientColors = [
//     Colors.red,
//     Colors.red,
//   ];
//   return LineChartData(
//     gridData: FlGridData(
//       show: true,
//       drawVerticalLine: true,
//       horizontalInterval: 1,
//       verticalInterval: 1,
//       getDrawingHorizontalLine: (value) {
//         return const FlLine(
//           color: Color(0xFF8915E4),
//           strokeWidth: 1,
//         );
//       },
//       getDrawingVerticalLine: (value) {
//         return const FlLine(
//           color: Color(0xFF8915E4),
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: const FlTitlesData(
//       show: true,
//       rightTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       topTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           interval: 1,
//           getTitlesWidget: bottomTitleWidgetsMonth,
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           interval: 1,
//           getTitlesWidget: leftTitleWidgets,
//           reservedSize: 52,
//         ),
//       ),
//     ),
//     borderData: FlBorderData(
//       show: true,
//       border: Border.all(color: const Color(0xff37434d)),
//     ),
//     minX: 0,
//     maxX: 12,
//     minY: 0,
//     maxY: 12,
//     lineBarsData: [
//       LineChartBarData(
//         spots: const [
//           FlSpot(0, 2),
//           FlSpot(4, 1),
//           FlSpot(8, 3),
//           FlSpot(12, 1),
//         ],
//         isCurved: true,
//         gradient: LinearGradient(
//           colors: gradientColors,
//         ),
//         barWidth: 5,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: true,
//           getDotPainter: (FlSpot spot, double percent, LineChartBarData barData,
//               int index) {
//             return ValueDotPainter();
//           },
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors:
//                 gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//           ),
//         ),
//       ),
//     ],
//   );
// }

class ValueDotPainter extends FlDotPainter {
  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final paint = Paint()..color = Colors.black38;
    final textStyle = const TextStyle(color: Color(0xFF8915E4), fontSize: 12);
    final textSpan =
        TextSpan(text: spot.y.toStringAsFixed(1), style: textStyle);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    // Draw circle dot
    canvas.drawCircle(offsetInCanvas, 4, paint);

    // Draw text
    final textOffset = Offset(
        offsetInCanvas.dx - textPainter.width / 2, offsetInCanvas.dy - 15);
    textPainter.paint(canvas, textOffset);
  }

  @override
  Size getSize(FlSpot spot) {
    return const Size(8, 8);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();
}
