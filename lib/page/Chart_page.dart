import 'package:calories_remake/Language/lang.dart';
import 'package:calories_remake/page/BMI_Edit.dart';
import 'package:calories_remake/page/BMR_Edit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {

  ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>with TickerProviderStateMixin {
  int height = 173;

  int weight = 62;

  int calo = 2010;
  bool showAvg = false;
  bool showAvg2 = false;
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 40),
              child: Text(lang('headingChart', 'Chart'),style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(left: 25,right: 25),
              alignment: Alignment.topLeft,
              child:  Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lang('subHeading1', 'BMI'),style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.primary),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BMI_Edit()));
                        },
                          child: const Icon(Icons.more_horiz,size: 35,)
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Theme.of(context).colorScheme.onSecondary,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(
                              0.5,0.5
                          ),
                          blurRadius: 2.2,
                          spreadRadius: 0.7,
                        ), //BoxShadows
                       //BoxShadow
                      ],
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10,),
                          Text('BMI',style: TextStyle( fontWeight: FontWeight.w800,
                              fontSize: 30.0,color: Theme.of(context).colorScheme.primary),),
                          const SizedBox(height: 20,),
                          const Text('21.0',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30,color: Color(0xFFD479FF)),),
                          const SizedBox(height: 20,),
                          Container(
                            margin: const EdgeInsets.only(left: 20,right: 20),
                            child: Divider(
                              height: 2,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 12,),
                          Container(
                            margin: const EdgeInsets.only(left: 50,right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(lang('h', 'Height'),style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.primary),),
                                    Text('$height cm',style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.primary))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(lang('w', 'Weight'),style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.primary)),
                                    Text('$weight kg',style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.primary))
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
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(left: 25,right: 25),
              alignment: Alignment.topLeft,
              child:  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lang('subHeading2', 'BMR'),style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.primary),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const BMR_Edit()));
                        },
                          child: const Icon(Icons.more_horiz,size: 35,
                          )
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity, // Maintain full width
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10), // Use radiusCircular for consistency
                      ),
                      color: Theme.of(context).colorScheme.onSecondary,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(
                              0.5,0.5
                          ),
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
                            margin: const EdgeInsets.only(left: 25,right: 25),
                            width: 1,
                            height: 100,
                            color: Colors.grey.shade700,

                          ),
                          Text(
                            '$calo/day',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30.0,
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
            const SizedBox(height: 20,),
            Container(margin: EdgeInsets.only(left: 25,right: 25,bottom: 7),child: Text(lang('chartCalo', 'Calo'),style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.primary),textAlign: TextAlign.center,)),
            Card(
              margin: EdgeInsets.only(left: 20,right: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const[
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(
                            0.5,0.5
                        ),
                        blurRadius: 2.0,
                        spreadRadius: 0.2,
                      ), //
                    ]
                ),
                child: TabBar(
                  tabAlignment: TabAlignment.center,
                  dividerHeight: 0,
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.background,fontWeight: FontWeight.bold,fontSize: 16,),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFD479FF),
                  ),
                  indicatorPadding: EdgeInsets.only(left: -75,right: -75),
                  isScrollable: true,
                  controller: tabController,
                  padding: EdgeInsets.only(left: 25,right: 25),
                  labelPadding: EdgeInsets.symmetric(horizontal:50),
                  tabs: [
                    Tab(text: lang('tabViewMonth','Month'),),
                    Tab(text: lang('tabViewYear','Year'),),
                  ],
                ),
              ),
            ),
            Container(
                height: 300,
              child: TabBarView(
              controller: tabController,
              children: [
                Tab(child: Stack(
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
                          CaloInDataMonth(),
                        ),
                      ),
                    ),
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
                          CaloOutDataMonth(),
                        ),
                      ),
                    ),
                  ],
                ),),
                Tab(
                  child: Stack(
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
                             CaloInDataYear(),
                          ),
                        ),
                      ),
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
                            CaloOutDataYear(),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ],
            ))


          ],
        ),
      ),
    );
  }
}
Widget bottomTitleWidgetsYear(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
    color: Colors.grey
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Jan', style: style);
      break;
    case 2:
      text = const Text('Feb', style: style);
      break;
    case 3:
      text = const Text('Mar', style: style);
      break;
    case 4:
      text = const Text('Apr', style: style);
      break;
    case 5:
      text = const Text('May', style: style);
      break;
    case 6:
      text = const Text('Jun', style:style);
      break;
    case 7:
      text = const Text('Jul', style: style);
      break;
    case 8:
      text = const Text('Aug', style:style);
      break;
    case 9:
      text = const Text('Sep', style: style);
      break;
    case 10:
      text = const Text('Oct', style:style);
      break;
    case 11:
      text = const Text('Nov', style: style);
      break;
    case 12:
      text = const Text('Dec', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
Widget bottomTitleWidgetsMonth(double value, TitleMeta meta) {
  const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.grey
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('W1', style: style);
      break;
    case 4:
      text = const Text('W2', style: style);
      break;
    case 8:
      text = const Text('W3', style: style);
      break;
    case 12:
      text = const Text('W4', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
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
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '1000 ';
      break;
    case 3:
      text = '1500 ';
      break;
    case 5:
      text = '2000 ';
      break;
    case 7:
      text = '2500 ';
      break;
    case 9:
      text = '3000 ';
      break;
    case 11:
      text = '3500 ';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
LineChartData CaloInDataYear() {
  List<Color> gradientColors = [
    Color(0xFF6CEA90),
    Color(0xFF6CEA90),
  ];
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
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
    titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgetsYear,
        ),
      ),
      leftTitles: AxisTitles(
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
    maxY: 12,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(1, 2),
          FlSpot(2, 5),
          FlSpot(3, 3.1),
          FlSpot(4, 4),
          FlSpot(5, 3),
          FlSpot(6, 3),
          FlSpot(7, 2),
          FlSpot(8, 5),
          FlSpot(9, 3.1),
          FlSpot(10, 4),
          FlSpot(11, 3),
          FlSpot(12, 3),
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData:  FlDotData(
          show: true,
          getDotPainter:  (FlSpot spot, double percent, LineChartBarData barData, int index){
            return ValueDotPainter();

          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ),
    ],
  );
}
LineChartData CaloOutDataYear() {
  List<Color> gradientColors = [
    Colors.red,
    Colors.red,
  ];
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
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
    titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgetsYear,
        ),
      ),
      leftTitles: AxisTitles(
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
    maxY: 12,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(1, 1),
          FlSpot(2, 3),
          FlSpot(3, 1),
          FlSpot(4, 2),
          FlSpot(5, 6),
          FlSpot(6, 5),
          FlSpot(7, 4),
          FlSpot(8, 3),
          FlSpot(9, 1.1),
          FlSpot(10, 2),
          FlSpot(11, 9),
          FlSpot(12, 9),


        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter:  (FlSpot spot, double percent, LineChartBarData barData, int index){
            return ValueDotPainter();

          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ),
    ],
  );
}
LineChartData CaloInDataMonth() {
  List<Color> gradientColors = [
    Color(0xFF6CEA90),
    Color(0xFF6CEA90),
  ];
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
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
    titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgetsMonth,
        ),
      ),
      leftTitles: AxisTitles(
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
    maxY: 12,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(4, 2),
          FlSpot(8, 5),
          FlSpot(12, 3.1),



        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData:  FlDotData(
          show: true,
          getDotPainter:  (FlSpot spot, double percent, LineChartBarData barData, int index){
            return ValueDotPainter();

          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ),
    ],
  );
}
LineChartData CaloOutDataMonth() {
  List<Color> gradientColors = [
    Colors.red,
    Colors.red,
  ];
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
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
    titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgetsMonth,
        ),
      ),
      leftTitles: AxisTitles(
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
    maxY: 12,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 2),
          FlSpot(4, 1),
          FlSpot(8, 3),
          FlSpot(12, 1),

        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter:  (FlSpot spot, double percent, LineChartBarData barData, int index){
            return ValueDotPainter();

          },
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors.map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ),
    ],
  );
}
class ValueDotPainter extends FlDotPainter {
  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final paint = Paint()..color = Colors.black38;
    final textStyle = TextStyle(color: Color(0xFF8915E4), fontSize: 12);
    final textSpan = TextSpan(text: spot.y.toStringAsFixed(1), style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    // Draw circle dot
    canvas.drawCircle(offsetInCanvas, 4, paint);

    // Draw text
    final textOffset = Offset(offsetInCanvas.dx - textPainter.width / 2, offsetInCanvas.dy - 15);
    textPainter.paint(canvas, textOffset);
  }

  @override
  Size getSize(FlSpot spot) {
    return const Size(8, 8);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  
}
