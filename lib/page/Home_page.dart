import 'package:calories_remake/page/NutritionDetail_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Language/lang.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double calories = 1230;
  double protein = 80;
  double currentValue = 100;
  double maxValue = 100;
  List<String> foodName = ['Sushi','Sandwich','Raman','Phở'];
  List<double> kcal = [80,134,100,102];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height:55,
                width: double.infinity,
                margin: EdgeInsets.only(left: 25,right: 25,top:20),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("data",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                      Spacer(),
                      Container(
                        height: 34,
                          width: 34,
                          child: ClipRRect(
                              child: Image.asset('assets/huh_cat.jpg',fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),

                      )
                    ],
                  ),
                ),
              ),//Heading
              Container(
                margin: EdgeInsets.only(top: 15,right: 25,left: 25),
                height: 420,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(188, 124, 237, 0.2),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Calories Budget",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                      SizedBox(height: 10,),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              height: 180,
                              width: 180,
                              child: CustomPaint(
                              painter: ShapePainter(process: 1000),
                              child: Container(
                              ),
                            )
                          ),

                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xFFF5E3FF)
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$calories",textAlign: TextAlign.center,style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                Text('Calories',textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 1500,
                        lineHeight: 18,
                        leading: Text("Proteins",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                        percent: 0.8,
                        center: Text("20/80",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
                        progressColor: Color(0xFFD479FF),
                        backgroundColor: Color(0xFFE5CAFF),
                        barRadius: Radius.circular(10),
                      ),
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 1500,
                        lineHeight: 18,
                        leading: Text("Carbs",style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                        percent: 0.8,
                        center: Text("20/80",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
                        progressColor: Color(0xFFD479FF),
                        backgroundColor: Color(0xFFE5CAFF),
                        barRadius: Radius.circular(10),
                      ),
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 1500,
                        lineHeight: 18,
                        leading: Text("Fats",style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                        percent: 0.8,
                        center: Text("20/80",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white ),),
                        progressColor: Color(0xFFD479FF),
                        backgroundColor: Color(0xFFE5CAFF),
                        barRadius: Radius.circular(10),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 25,top: 30),
                  child: Align(alignment: Alignment.topLeft,
                      child: Text(lang('heading2Home','Recent Meal'),style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Color(0xFFD479FF)),)
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 25,right: 25),
                height: 300,
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const NutritionDetail_page()));
                        },
                        child: Container(
                          height:53,
                          width: double.infinity,
                          margin: EdgeInsets.only(top:10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const[
                                BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(
                                        0.2,0.2
                                    ),
                                    blurRadius: 2.0,
                                    spreadRadius: 0.2
                                )
                              ],
                              color: Theme.of(context).colorScheme.onSecondary
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            child: Row(
                              children: [
                                Container(
                                  height: 34,
                                  width: 34,
                                  margin: EdgeInsets.only(right: 5),
                                  child: ClipRRect(
                                      child: Image.asset('assets/huh_cat.jpg',fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                ),
                                Text(foodName[index],style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                Spacer(),
                                Text('${kcal[index]} kcal',style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                              ],
                            ),
                          ),
                        ),
                      );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ShapePainter extends CustomPainter {
  double? process;
  ShapePainter({this.process});
  @override
  void paint(Canvas canvas, Size size) {
    var paintBk = Paint();
    paintBk.strokeWidth = 15;
    paintBk.color = Color(0xFFE5CAFF);
    paintBk.strokeCap = StrokeCap.round;
    paintBk.style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 3*math.pi/4, 6*math.pi/4, false, paintBk);

    var paintProcess = Paint();
    paintProcess.strokeCap = StrokeCap.round;
    paintProcess.style = PaintingStyle.stroke;
    paintProcess.color =Color(0xFFD479FF);
    paintProcess.strokeWidth = 15;
    double precentage = 3*math.pi/2*(process!/1230);
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 3*math.pi/4, precentage, false, paintProcess);

    double radious = size.width/2;
    double centerX = size.width/2;
    double centerY = size.height/2;
    double position = 3*math.pi/4+precentage;
    double x = centerX + radious *math.cos(position);
    double y = centerY +radious *math.sin(position);
    var dot = Paint();
    dot.color = Colors.white;
    canvas.drawCircle(Offset(x, y), 12, dot);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

