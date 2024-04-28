import 'package:calories_remake/page/NutritionDetail_page.dart';
import 'package:flutter/material.dart';

import '../Language/lang.dart';

class MenuFood extends StatelessWidget {
  const MenuFood({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> foodName = ['Sushi','Sandwich','Raman','Phở','Sushi','Sandwich','Raman','Phở','Sushi','Sandwich',];
    List<int> kcal=[20,30,20,50,80,32,59,67,93,10];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 40),
              child: Text(lang('FoodMenu', 'Menu'),style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),),
            ),
            Container(
              height: 700,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 70),
                child: ListView.builder(
                    itemCount: foodName.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NutritionDetail_page()));
                        },
                        child: Container(
                          height:60,
                          margin: EdgeInsets.all(6.5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(8),
                              boxShadow: const[
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(
                                      0.5,0.5
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.5
                              )
                          ],),
                          child: Container(
                            margin: EdgeInsets.only(left: 15,right: 15),
                            child: Row(
                              children: [
                              Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                  child: Image.asset('assets/huh_cat.jpg',fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Text(foodName[index],style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 15,fontWeight: FontWeight.bold)),
                                  Text("100g -${kcal[index]} kcal",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 12)),
                                ],
                              ),
                            ),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration:BoxDecoration(
                                      color: Color(0xFFD99BF5),
                                      borderRadius: BorderRadius.circular(10)

                                    ) ,
                                    child: Icon(Icons.add,color: Theme.of(context).colorScheme.background,),
                                  ),
                                ),
                              ]
                          ),
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
