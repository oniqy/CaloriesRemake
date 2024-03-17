import 'package:flutter/material.dart';
class Edit_BMR_Information extends StatefulWidget {
  const Edit_BMR_Information({super.key});

  @override
  State<Edit_BMR_Information> createState() => _Edit_BMR_InformationState();
}

class _Edit_BMR_InformationState extends State<Edit_BMR_Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('edit'),backgroundColor: Theme.of(context).colorScheme.background,),
    );
  }
}
