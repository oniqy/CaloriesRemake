import 'package:calories_remake/Language/lang.dart';
import 'package:calories_remake/page/Edit_Index_Infomation.dart';
import 'package:flutter/material.dart';

class BMR_Edit extends StatefulWidget {
  const BMR_Edit({super.key});

  @override
  State<BMR_Edit> createState() => _BMR_EditState();
}

class _BMR_EditState extends State<BMR_Edit> {
  int bmr = 2010;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(lang('subHeading2', "BMR"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_BMR_Information()));

              },
              child: Container(
                  margin: EdgeInsets.only(left: 25,right: 25,top: 20),
                  child: Text(lang('EditBMR', 'data'),style: TextStyle(color: Theme.of(context).colorScheme.primary,decoration: TextDecoration.underline),)),
            ),
            Container(
              margin: EdgeInsets.only(left: 25,right: 25,top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(40),bottomLeft: Radius.circular(40),topLeft: Radius.circular(10),bottomRight: Radius.circular(10)
                ),
                color: Theme.of(context).colorScheme.onSecondary,
                boxShadow: const [BoxShadow(
                  color: Colors.black38,
                  offset: Offset(
                    2.0,
                    2.0
                  ),
                  blurRadius: 2.0,
                  spreadRadius: 0.7,
                )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 20,left: 20),
                            child: Text('BMR',style: TextStyle(color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 30.0,),
                            )
                        ),
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20,left: 20),
                          child: Column(
                            children: [
                              Text(
                                '$bmr/day',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Color(0xFF8915E4),
                                ),
                              ),
        
        
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Divider(height: 1,color: Colors.grey.shade700,)
                    ),
                    Container(
                      child: Text(lang('BMRdetail', 'Basal Metabolic Rate'),maxLines: 3,textAlign: TextAlign.center,style:
                        TextStyle(color: Theme.of(context).colorScheme.primary)
                        ,),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25,right: 25,top: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(40),bottomLeft: Radius.circular(40),topLeft: Radius.circular(10),bottomRight: Radius.circular(10)
                  ),
                  color: Theme.of(context).colorScheme.onSecondary,
                  boxShadow: const [BoxShadow(
                    color: Colors.black38,
                    offset: Offset(
                        2.0,
                        2.0
                    ),
                    blurRadius: 2.0,
                    spreadRadius: 0.7,
                  )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 20,left: 20),
                            child: Text('TDEE',style: TextStyle(color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 30.0,),
                            )
                        ),
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20,left: 20),
                          child: Column(
                            children: [
                              Text(
                                '$bmr/day',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Color(0xFF8915E4),
                                ),
                              ),
        
        
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Divider(height: 1,color: Colors.grey.shade700,)
                    ),
                    Container(
                      child: Text(lang("TDEEdetail", "Total Daily Energy Expenditure"),maxLines: 3,textAlign: TextAlign.center,style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)
                        ,),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25,right: 25,top: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(40),bottomLeft: Radius.circular(40),topLeft: Radius.circular(10),bottomRight: Radius.circular(10)
                  ),
                  color: Theme.of(context).colorScheme.onSecondary,
                  boxShadow: const [BoxShadow(
                    color: Colors.black38,
                    offset: Offset(
                        2.0,
                        2.0
                    ),
                    blurRadius: 2.0,
                    spreadRadius: 0.7,
                  )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 7,left: 5),
                            child: Text('Target',style: TextStyle(color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 30.0,),
                            )
                        ),
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15,left: 20),
                          child: Column(
                            children: [
                              Text(
                                '$bmr/day',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Color(0xFF8915E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Divider(height: 1,color: Colors.grey.shade700,)
                    ),
                    Container(
                      child: Text(lang("TargetDetail", "Target"),maxLines: 3,textAlign: TextAlign.center,style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)
                        ,),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
