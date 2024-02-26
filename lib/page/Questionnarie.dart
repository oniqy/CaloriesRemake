import 'package:calories_remake/lang.dart';
import 'package:flutter/material.dart';
import 'package:calories_remake/page/Questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'BottomNavigator.dart';

class Questionnaire extends StatefulWidget {
  final List<Question> questions;
  const Questionnaire({Key? key, required this.questions}) : super(key: key);

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  final TextEditingController _controller = TextEditingController();
  int currentIndex = 0;
  List<bool> itemFocusList = List<bool>.filled(4, false);
  List<Image> assetPaths = [
    Image.asset('assets/CaloBurn.png'),
    Image.asset('assets/meditation2.png'),
    Image.asset('assets/musclee.png'),
    Image.asset('assets/balanceBody.png')
  ];
  List<String> textGoal = [lang("textGoal1", 'Lose Weight'),lang("textGoal2", 'Be Healthier'),lang("textGoal3", 'Build Muscle'),lang("textGoal4", 'Balance Body')];
  void nextIndex() {
    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        currentIndex++;
        _controller.clear();
      });
    } else {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigator()));
      });
    }
  }

  void previousIndex() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = widget.questions[currentIndex];
    return Scaffold(
      body: Column(
        children: [
          if(currentIndex>0)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 20,top: 30),
                  child:ElevatedButton(
                  onPressed: previousIndex,
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              )
            ),
          SizedBox(height: 100,),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  widget.questions[currentIndex].questionText,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                Text(
                  widget.questions[currentIndex].subText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey)),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: currentIndex == 0 ? 
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                   margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                   // Đặt chiều cao cho GridView
                    child: GridView.builder(
                      //
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 1,
                        mainAxisExtent: 190,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: (){
                          setState(() {
                            itemFocusList[index]=!itemFocusList[index];
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: itemFocusList[index]?const Color(0xFF8915E4):Colors.black,
                                  width: 3
                                ),
                                color: itemFocusList[index]?const Color(0xFFE9E1F3):Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 5),
                                          child: assetPaths[index],
                                      ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                      child: Text(textGoal[index],style: TextStyle(
                                        color: itemFocusList[index]?Color(0xFF8915E4):Colors.black,
                                        fontWeight: FontWeight.w600
                                      ),)
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextField(
                          controller: _controller,
                          keyboardType: widget.questions[currentIndex].inputType,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  gapPadding: 3.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20,left: 25,right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:List.generate(widget.questions.length, (index) {
                    return Expanded(child: Container(
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: index==currentIndex?Color(0xFF8915E4):Colors.grey,
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ));
                  })
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25,left: 25,right: 25),
            child: ElevatedButton(
                onPressed: nextIndex,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF8915E4),
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ), child: Text(currentIndex == widget.questions.length - 1 ? 'Apply' : 'Next',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),)
            ),
          ),
        ],
      ),
    );
  }
}
