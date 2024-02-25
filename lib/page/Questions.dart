import 'package:flutter/material.dart';
class Question{
  final String questionText;
  TextInputType inputType;
  Question({required this.questionText,this.inputType = TextInputType.text});

}