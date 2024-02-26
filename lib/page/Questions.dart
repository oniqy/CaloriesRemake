import 'package:flutter/cupertino.dart';

class Question {
  final String questionText;
  final String subText;
  final TextInputType inputType;

  // Cung cấp giá trị mặc định cho subText
  Question({
    required this.questionText,
    required this.subText , // Giá trị mặc định là một chuỗi rỗng
    this.inputType = TextInputType.text,
  });
}