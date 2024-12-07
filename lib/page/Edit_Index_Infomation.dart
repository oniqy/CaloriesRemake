import 'package:calories_remake/Language/lang.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Edit_BMR_Information extends StatefulWidget {
  const Edit_BMR_Information({super.key});

  @override
  State<Edit_BMR_Information> createState() => _Edit_BMR_InformationState();
}

class _Edit_BMR_InformationState extends State<Edit_BMR_Information> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final List<String> exerciseLevels = ['Không Tập', 'Ít', 'Vừa', 'Nặng'];
  final List<String> goals = ['Giảm Cân', 'Duy Trì', 'Tăng Cân', 'Khỏe Mạnh'];

  String? selectedExerciseLevel;
  String? selectedGoal;

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD479FF);

    const borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );

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
                            color: Color(0xFFE5CAFF),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF5C0187),
                        ),
                      ),
                    )),
                Text(
                  lang("editHeading1", "Edit BMR"),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: const InputDecoration(
                  labelText: 'Chiều Cao (cm)',
                  border: borderStyle,
                  focusedBorder: borderStyle,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: const InputDecoration(
                  labelText: 'Cân Nặng (kg)',
                  border: borderStyle,
                  focusedBorder: borderStyle,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: const InputDecoration(
                  labelText: 'Tuổi',
                  border: borderStyle,
                  focusedBorder: borderStyle,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tập luyện',
                  border: borderStyle,
                  focusedBorder: borderStyle,
                ),
                items: exerciseLevels
                    .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(
                          level,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        )))
                    .toList(),
                value: selectedExerciseLevel,
                onChanged: (value) {
                  setState(() {
                    selectedExerciseLevel = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Mục Tiêu',
                  border: borderStyle,
                  focusedBorder: borderStyle,
                ),
                items: goals
                    .map((goal) => DropdownMenuItem(
                        value: goal,
                        child: Text(
                          goal,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        )))
                    .toList(),
                value: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final height = _heightController.text;
                    final weight = _weightController.text;
                    final age = _ageController.text;

                    print('Chiều cao: $height');
                    print('Cân nặng: $weight');
                    print('Tuổi: $age');
                    print('Tập luyện: $selectedExerciseLevel');
                    print('Mục tiêu: $selectedGoal');
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF5C0187),
                      disabledBackgroundColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.12),
                      animationDuration: const Duration(seconds: 1),
                      minimumSize: const Size(170, 47)),
                  child: Text(
                    'Lưu Thông Tin',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
