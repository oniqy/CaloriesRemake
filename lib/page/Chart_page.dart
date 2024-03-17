import 'package:calories_remake/Language/lang.dart';
import 'package:calories_remake/page/BMI_Edit.dart';
import 'package:calories_remake/page/BMR_Edit.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  int height = 173;
  int weight = 62;
  int calo = 2010;
  ChartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 40),
              child: Text(lang('headingChart', 'Chart'),style: TextStyle(
                  fontSize: 20,
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
                            2.0,
                            2.0,
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
                          const Text('21.0',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30,color: Color(0xFF8915E4)),),
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
                            2.0,
                            2.0,
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
                              color: Color(0xFF8915E4),
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

          ],
        ),
      ),
    );
  }
}
