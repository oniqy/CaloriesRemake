import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Language/lang.dart';
import '../Witget/Indicator.dart';
class NutritionDetail_page extends StatelessWidget {
  const NutritionDetail_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        flexibleSpace:
        Container(
         height: 60,
          width: double.infinity,
          margin: EdgeInsets.only(left: 25,right: 25,top:40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const[
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset(
                        0.5,0.5
                    ),
                    blurRadius: 2.0,
                    spreadRadius: 0.3
                )
              ],
              color: Theme.of(context).colorScheme.onSecondary
          ),
          child: Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:  Color(0xFFE5CAFF),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.arrow_back,color: Color(0xFF5C0187),),
                    ),
                  )
                ),
                Text(lang("AppBarDetailFood","Nutrition Details"),style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                Container(
                    height: 30,
                    width: 30,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:  Color(0xFFE5CAFF),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.fastfood_rounded,color: Color(0xFF5C0187),),
                      ),
                    )
                ),
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
                margin: EdgeInsets.only(left: 25,right: 25),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Name of food",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).colorScheme.primary),),
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(left: 25,right: 25,top: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text('100 kcal'),
                          PieChart(
                              swapAnimationDuration: Duration(milliseconds: 1000),
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: 80,
                                  color: Color(0xFFFB7E93)
                                ),
                                PieChartSectionData(
                                    value: 20,
                                    color: Color(0xFF6CEA90)
                                ),
                                PieChartSectionData(
                                    value: 20,
                                    color: Color(0xFFF3B838)
                                )
                              ]
                            )

                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 20,),
                    Text(lang("targetDaily", 'target'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).colorScheme.primary),),
                    Container(
                      margin: EdgeInsets.only(top:10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow:const [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(
                              0.5,0.5
                            ),
                            blurRadius: 2.0,
                            spreadRadius: 0.3
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Carbs',style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                            SizedBox(height: 5,),
                            Stack(
                              children: [
                                LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1500,
                                  lineHeight: 18,
                                  percent: 0.8,
                                  progressColor: Color(0xFFFB7E93),
                                  backgroundColor: Color(0xFFE7E7E7),
                                  barRadius: Radius.circular(10),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        "80%",
                                        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('Fats',style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                            SizedBox(height: 5,),
                            Stack(
                              children: [
                                LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1500,
                                  lineHeight: 18,
                                  percent: 0.8,
                                  progressColor: Color(0xFF6CEA90),
                                  backgroundColor: Color(0xFFE7E7E7),
                                  barRadius: Radius.circular(10),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        "80%",
                                        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('Proteins',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                            SizedBox(height: 5,),
                            Stack(
                              children: [
                                LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1500,
                                  lineHeight: 18,
                                  percent: 0.8,
                                  progressColor: Color(0xFFF3B838),
                                  backgroundColor: Color(0xFFE7E7E7),
                                  barRadius: Radius.circular(10),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(
                                        "80%",
                                        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
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

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(lang('exchangeCalo','ExchangeCalories')+"kcal",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                        Spacer(),
                        Icon(Icons.arrow_right_alt_outlined,color: Color(0xFF5C0187),size: 35,)
                      ],
                    ),
                    SizedBox(height: 100)

                  ],
                ),
              ),
            ),

            Positioned(
              left: 25,
              right: 25,
              bottom: 15,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFE5CAFF),
                    boxShadow: const[
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.5,0.5),
                          blurRadius: 2.0,
                          spreadRadius: 0.3
                      )
                    ]
                ),
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(lang('UpdateDailyMenu','UpdateDailyMenu'),style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                    SizedBox(width: 10,),
                    Icon(Icons.add_sharp,color: Color(0xFF5C0187),size: 25,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
