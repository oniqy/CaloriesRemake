import 'package:calories_remake/language/lang.dart';
import 'package:calories_remake/domain/entities/user_info.dart';
import 'package:calories_remake/domain/usecases/create_user_information.dart';
import 'package:calories_remake/domain/usecases/edit_user_information.dart';
import 'package:calories_remake/page/BottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit_BMR_Information extends StatefulWidget {
  const Edit_BMR_Information({super.key});

  @override
  State<Edit_BMR_Information> createState() => _Edit_BMR_InformationState();
}

class _Edit_BMR_InformationState extends State<Edit_BMR_Information>
    with SingleTickerProviderStateMixin {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  final Map<String, String> exerciseMapping = {
    'Không Tập': 'khongTap',
    'Ít': 'It',
    'Vừa': 'Vua',
    'Nặng': 'Nang',
  };
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final Map<String, String> goalsMapping = {
    'Giảm Cân': 'GiamCan',
    'Duy Trì': 'DuyTri',
    'Tăng Cân': 'TangCan',
    'Khỏe Mạnh': 'KhoeManh',
  };

  String? selectedExerciseLevel;
  String? selectedGoal;
  Future<int?> getUserAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userAccountId = prefs.getInt('userAccountId');
    return userAccountId;
  }

  void _showDialogCheckInput(
      String header, String body, Icon icon, int verifyE) {
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlideTransition(
          position: _offsetAnimation,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              children: [
                icon,
                const SizedBox(width: 8),
                Text(
                  header,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(body),
                const SizedBox(height: 20),
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF5177FF),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BottomNavigator(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); 
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        ),
      );
    }).then((_) {
      _controller.reset();
    });
  }

  UserInfoEntity userInfo = UserInfoEntity(
    userAccountId: 0,
    userHeight: 0.0,
    userWeight: 0.0,
    exerciseIntensity: '',
    target: '',
    age: 0,
  );
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
                          color:  Color(0xFF5C0187),
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
              const SizedBox(
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
                items: exerciseMapping.keys.map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(
                      level,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  );
                }).toList(),
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
                items: goalsMapping.keys.map((String goal) {
                  return DropdownMenuItem<String>(
                    value: goal,
                    child: Text(
                      goal,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  );
                }).toList(),
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
                  onPressed: () async {
                    int? userAccountId = await getUserAccountId();
                    final height = double.tryParse(_heightController.text);
                    final weight = double.tryParse(_weightController.text);
                    final age = int.tryParse(_ageController.text);
                    final convertedExerciseLevel =
                        exerciseMapping[selectedExerciseLevel];
                    final convertedGoal = goalsMapping[selectedGoal];

                    int? statusCode = await editUSerInfo(
                        userAccountId!,
                        height! as double,
                        weight as double,
                        convertedExerciseLevel!,
                        convertedGoal!,
                        age as int);
                    if (statusCode == 200) {
                      _showDialogCheckInput(
                          'Lưu thông số mới thành công',
                          'Đang cập nhật lại thông tin ..... ',
                          const Icon(
                            Icons.verified,
                            color:  Color(0xFFD99BF5),
                          ),
                          1);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Lưu thông tin thất bại. Vui lòng thử lại."),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFD99BF5),
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
