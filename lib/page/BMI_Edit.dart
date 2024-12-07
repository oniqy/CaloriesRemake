import 'package:flutter/material.dart';

import '../Language/lang.dart';

class BMI_Edit extends StatefulWidget {
  BMI_Edit({super.key});

  @override
  State<BMI_Edit> createState() => _BMI_EditState();
}

class _BMI_EditState extends State<BMI_Edit> {
  final TextEditingController _inputHieght = TextEditingController();
  final TextEditingController _inputWeight = TextEditingController();
  String bmi = "";
  void tinhBMI(int w, int h) {
    setState(() {
      double h2 = h / 100;
      double cal = w / (h2 * h2);
      bmi = double.parse(cal.toStringAsFixed(2)).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25, right: 25, top: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 2.0,
                    spreadRadius: 0.3)
              ],
              color: Theme.of(context).colorScheme.onSecondary),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFE5CAFF),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF5C0187),
                        ),
                      ),
                    )),
                Text(
                  lang("subHeading1", "BMI"),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        leading: Container(width: 0.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Theme.of(context).colorScheme.background,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 2.0,
                    spreadRadius: 0.7,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          lang('h', "Height"),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _inputHieght,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            decoration: const InputDecoration(
                              hintText: '...cm',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          lang("w", "Weight"),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _inputWeight,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            decoration: const InputDecoration(
                              hintText: "...kg",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          tinhBMI(
                            int.parse(_inputWeight.value.text),
                            int.parse(_inputHieght.value.text),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF8915E4),
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        child: Text(
                          lang('CalBMI', "cal"),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lang('bmiCount', "BMI"),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    bmi,
                    style: const TextStyle(
                      color: Color(0xFF8915E4),
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: ClipRRect(
                child: Image.asset(
                  'assets/tyleBMI.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
