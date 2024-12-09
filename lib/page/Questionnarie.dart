import 'package:calories_remake/language/lang.dart';
import 'package:calories_remake/domain/entities/user_info.dart';
import 'package:calories_remake/domain/usecases/create_user_information.dart';
import 'package:calories_remake/page/Questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'BottomNavigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questionnaire extends StatefulWidget {
  final List<Question> questions;
  const Questionnaire({Key? key, required this.questions}) : super(key: key);

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  final TextEditingController _controller = TextEditingController();
  int currentIndex = 0;
  List<bool> itemFocusList = List<bool>.filled(5, false);
  List<Image> assetPaths = [
    Image.asset('assets/CaloBurn.png'),
    Image.asset('assets/meditation2.png'),
    Image.asset('assets/musclee.png'),
    Image.asset('assets/balanceBody.png')
  ];
  List<String> timePerWeek = [
    'Không Tập',
    'Ít tập',
    "Tập vừa phải",
    "Cường độ mạnh"
  ];
  List<String> enumDataEx = ['khongTap', 'It', "Vua", "Nang"];
  List<String> subEx = [
    '0 buổi/tuần',
    '1-2 buổi/Tuần',
    '3-4 buổi/Tuần',
    '5-6 buổi/Tuần'
  ];
  List<String> textGoal = [
    lang("textGoal2", 'Lose Weight'),
    lang("textGoal3", 'Be Healthier'),
    lang("textGoal1", 'Build Muscle'),
    lang("textGoal4", 'Balance Body')
  ];
  List<String> getTarget = ["GiamCan", "KhoeManh", "TangCan", "DuyTri"];
  void nextIndex() async {
    if (currentIndex == 2) {
      userInfo.age = int.tryParse(_controller.text) ?? 0;
    } else if (currentIndex == 3) {
      userInfo.userHeight = double.tryParse(_controller.text) ?? 0.0;
    } else if (currentIndex == 4) {
      userInfo.userWeight = double.tryParse(_controller.text) ?? 0.0;
    }

    // Điều hướng đến câu hỏi tiếp theo
    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        currentIndex++;
        _controller.clear();
      });
    } else {
      if (itemFocusList.contains(true)) {
        int? userAccountId = await getUserAccountId();
        userInfo.userAccountId = userAccountId!;
        userInfo.target = getTarget[itemFocusList.indexWhere((e) => e)];
        userInfo.exerciseIntensity =
            enumDataEx[itemFocusList.indexWhere((e) => e)];
        int? statusCode = await createUserInfo(
          userInfo.userAccountId,
          userInfo.userHeight,
          userInfo.userWeight,
          userInfo.exerciseIntensity,
          userInfo.target,
          userInfo.age,
        );
        if (statusCode == 200) {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavigator()));
          });
        }
      }
    }
  }

  Future<int?> getUserAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userAccountId = prefs.getInt('userAccountId');
    return userAccountId;
  }

  UserInfoEntity userInfo = UserInfoEntity(
    userAccountId: 0,
    userHeight: 0.0,
    userWeight: 0.0,
    exerciseIntensity: '',
    target: '',
    age: 0,
  );
  void previousIndex() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ủa Ủa Gì Dợ"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF8915E4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void checkUserInput() {
    if (currentIndex <= 1) {
      if (selectedIndexes[currentIndex] == null) {
        showErrorDialog("Hình như bạn quên chọn các Option trên");
        return;
      }
    } else {
      if (_controller.text.isEmpty) {
        showErrorDialog("Bạn lại quên điền thông tin nữa rồi");
        return;
      }
    }

    nextIndex();
  }

  List<int?> selectedIndexes = [null, null];

  Widget getQuestionare() {
    if (currentIndex <= 1) {
      return Container(
        alignment: Alignment.center,
        height: 150,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        // Đặt chiều cao cho GridView
        child: GridView.builder(
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 1,
            mainAxisExtent: 190,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndexes[currentIndex] = index;
                itemFocusList = List<bool>.filled(5, false); // Reset the list
                itemFocusList[index] = true;
                if (currentIndex == 0) {
                  userInfo.target = getTarget[index];
                } else {
                  userInfo.exerciseIntensity = enumDataEx[index];
                }
              });
            },
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndexes[currentIndex] == index
                          ? const Color(0xFF8915E4)
                          : Colors.black,
                      width: 3,
                    ),
                    color: selectedIndexes[currentIndex] == index
                        ? const Color(0xFFE9E1F3)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, top: 10, bottom: 5),
                          child: currentIndex == 0
                              ? assetPaths[index]
                              : Center(
                                  child: Text(
                                    timePerWeek[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: selectedIndexes[currentIndex] ==
                                                index
                                            ? const Color(0xFF8915E4)
                                            : Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          currentIndex == 0 ? textGoal[index] : subEx[index],
                          style: TextStyle(
                              color: selectedIndexes[currentIndex] == index
                                  ? const Color(0xFF8915E4)
                                  : Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              controller: _controller,
              keyboardType: widget.questions[currentIndex].inputType,
              onChanged: (value) {
                // Cập nhật userInfo dựa trên chỉ số câu hỏi hiện tại
                if (currentIndex == 1) {
                  userInfo.age = int.tryParse(value) ?? 0;
                } else if (currentIndex == 2) {
                  userInfo.userHeight = double.tryParse(value) ?? 0.0;
                } else if (currentIndex == 3) {
                  userInfo.userWeight = double.tryParse(value) ?? 0.0;
                }
              },
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  gapPadding: 3.0,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (currentIndex > 0)
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 35),
                  child: GestureDetector(
                    onTap: previousIndex,
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                )),
          const SizedBox(
            height: 100,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    widget.questions[currentIndex].questionText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text(
                    widget.questions[currentIndex].subText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: getQuestionare()),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.questions.length, (index) {
                      return Expanded(
                          child: Container(
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: index == currentIndex
                                ? const Color(0xFF8915E4)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                      ));
                    })),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
            child: ElevatedButton(
              onPressed: checkUserInput,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF8915E4),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                currentIndex == widget.questions.length - 1 ? 'Apply' : 'Next',
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
