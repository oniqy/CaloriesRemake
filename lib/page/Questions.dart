import 'package:flutter/cupertino.dart';

class Question {
  final String questionText;
  final String subText;
  final TextInputType inputType;

  Question({
    required this.questionText,
    required this.subText,
    this.inputType = TextInputType.text,
  });
}
