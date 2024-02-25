import 'package:flutter/material.dart';
import 'package:calories_remake/page/Questions.dart';
import 'package:google_fonts/google_fonts.dart';
class Questionnaire extends StatefulWidget {
  final List<Question> questions;
  const Questionnaire({Key?key, required this.questions}):super(key: key);

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}
class _QuestionnaireState extends State<Questionnaire> {
  int currentIndex = 0;
  void nextIndex(){
      if(currentIndex<widget.questions.length-1){
        setState(() {
          currentIndex++;
        });
      }
  }
  void previousIndex(){
      if(currentIndex>0){
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
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentQuestion.questionText,style: GoogleFonts.poppins(textStyle:
          TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary
          )),),
          TextField(),
          ElevatedButton(onPressed: (){
            nextIndex();
          },
              child: Text(currentIndex==widget.questions.length-1?'Apply':'Next')
          ),

          if (currentIndex > 0)
            Positioned(
              bottom: 20,
              child: ElevatedButton(onPressed: (){
                previousIndex();
              }, child: Text('Previous')
              ),
            )
        ],
        ),
    );
  }
}
