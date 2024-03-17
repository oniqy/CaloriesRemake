import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Language/lang.dart';
class BMI_Edit extends StatefulWidget {

   BMI_Edit({super.key});

  @override
  State<BMI_Edit> createState() => _BMI_EditState();
}

class _BMI_EditState extends State<BMI_Edit> {
   final TextEditingController _inputHieght =  TextEditingController();
   final TextEditingController _inputWeight = TextEditingController();
    String bmi ="";
   void tinhBMI(int w,int h){
     setState((){
       double h2 = h/100;
       double cal =  w/(h2*h2);
       bmi = double.parse(cal.toStringAsFixed(2)).toString();
     });

   }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(lang("subHeading1","BMI")),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
              ),
              color: Theme.of(context).colorScheme.background,
              boxShadow:const[ BoxShadow(
                color: Colors.black38,
                offset: Offset(
                  2.0,2.0
                ),
                blurRadius: 2.0,
                spreadRadius: 0.7
              )]
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(lang('h', "Height"),style:TextStyle(color:  Theme.of(context).colorScheme.primary,fontSize: 20)),
                      SizedBox(width: 20,),
                      Expanded(
                        child: TextField(
                          controller: _inputHieght,
                          textAlign: TextAlign.center,
                          style:TextStyle(
                              color: Theme.of(context).colorScheme.primary
                          ),
                          decoration: const InputDecoration(
                            hintText: '...cm',


                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(lang("w", "Weight"),style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 20),),
                      SizedBox(width: 20,),
                      Expanded(child: TextField(
                        controller: _inputWeight,
                        textAlign: TextAlign.center,
                        style:TextStyle(
                            color: Theme.of(context).colorScheme.primary
                        ),
                        decoration:  InputDecoration(
                          hintText: "...kg",
                        ),
                        keyboardType: TextInputType.number,
                      ))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                    child: ElevatedButton(
                      onPressed: (){
                        tinhBMI(int.parse(_inputWeight.value.text) ,int.parse(_inputHieght.value.text));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF8915E4),
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 45),
                      ),
                      child: Text(lang('CalBMI', "cal"),style: TextStyle(fontSize: 20),),
                    ),
                  ),


                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 25,right: 25,top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Chỉ số BMI của bạn là ',style: TextStyle(color: Theme.of(context).colorScheme.primary,  fontSize: 20,
                    ),),
                  Text('$bmi',style: TextStyle(color: Color(0xFF8915E4),fontSize: 23,fontWeight: FontWeight.w600),)
                ],
              )),


        ],
      ),

    );
  }
}
