import 'dart:convert';

import 'package:calories_remake/language/lang.dart';
import 'package:calories_remake/domain/usecases/get_userInfo_byId.dart';
import 'package:calories_remake/domain/usecases/usecase_login.dart';
import 'package:calories_remake/page/BottomNavigator.dart';
import 'package:calories_remake/page/ForgotPassword_page.dart';
import 'package:calories_remake/page/Signup_page.dart';
import 'package:calories_remake/theme/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'Questionnarie.dart';
import 'Questions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_page extends StatefulWidget {
  Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page>
    with SingleTickerProviderStateMixin {
  bool currentTheme = false;
  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool isLoginSuc = false;
  void setTheme() {
    setState(() {
      currentTheme = !currentTheme;
    });
  }

  @override
  void initState() {
    super.initState();
    print('Login_page initState');
    _emailFocus.addListener(() {
      setState(() {
        isEmailFocused = _emailFocus.hasFocus;
      });
    });
    _passwordFocus.addListener(() {
      setState(() {
        isPasswordFocused = _passwordFocus.hasFocus;
      });
    });
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

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    isLoginSuc = false;
    super.dispose();
  }

  void login() async {
    String email = _email.text;
    String password = _password.text;
    int? isLogin = await loginUser(email, password);
    if (isLogin == 200) {
      setState(() {
        isLoginSuc = true;
      });
      _showDialogCheckInput(
          'Đăng nhập thành công',
          'Đang đi đến trang chủ...',
          const Icon(
            Icons.verified,
            color: Colors.green,
          ),
          1);

      await Future.delayed(const Duration(seconds: 3));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userAccountId = prefs.getInt('userAccountId');
      int? alreadyHaveInfo = await getUserInfoById(userAccountId!);
      if (alreadyHaveInfo == 404) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Questionnaire(questions: [
                      Question(
                          questionText:
                              lang('questionText1', 'What are your goals?'),
                          subText: lang('subText1', 'Select all that apply')),
                      Question(
                          questionText: lang('questionText1.5',
                              'About your Exercise Intensity?'),
                          subText: lang('subText1', 'Select all that apply')),
                      Question(
                          questionText:
                              lang('questionText2', 'How old are you?'),
                          subText: lang('subText2',
                              'This help us create your personalized plan')),
                      Question(
                          questionText:
                              lang('questionText3', 'How tall are you?'),
                          subText: lang('subText3',
                              'This help us create your personalized plan')),
                      Question(
                          questionText: lang(
                              'questionText4', 'What is your latest weight?'),
                          subText: lang('subText4',
                              'You can update your weight anytime')),
                    ])));
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigator()),
        );
      }
    } else if (isLogin == 401) {
      setState(() {
        isLoginSuc = false;
      });
      _showDialogCheckInput(
          'Đăng nhập thất bại',
          'Vui lòng kiểm tra email và mật khẩu của bạn.',
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          1);
    } else if (isLogin == 400) {
      setState(() {
        isLoginSuc = false;
      });
      _showDialogCheckInput(
          'Đăng nhập thất bại',
          'Bạn cần phải nhập thông tin.',
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          1);
    } else {
      setState(() {
        isLoginSuc = false;
      });
      _showDialogCheckInput(
        'Đăng nhập thất bại',
        'Có vẻ như server bị gì rồi',
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
        0,
      );
    }
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
            content: Text(body),
            actions: isLoginSuc
                ? <Widget>[
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF5177FF),
                      ),
                    ),
                  ]
                : <Widget>[
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
          ),
        );
      },
    ).then((_) {
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 75),
                      height: 70,
                      child: Text(
                        lang('welcome', 'Welcome to Calories tracker'),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 25,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 55, right: 55),
                    child: Image.asset('assets/backgroudLogin.png'),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: TextField(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          controller: _email,
                          focusNode: _emailFocus,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: isEmailFocused
                                  ? const Color(0xFF8915E4)
                                  : Colors.grey,
                            ),
                            hintText: lang('typeEmail', 'Enter your email'),
                            hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: isEmailFocused
                                        ? const Color(0xFF8915E4)
                                        : Colors.grey)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF8915E4)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: TextField(
                          controller: _password,
                          focusNode: _passwordFocus,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: isPasswordFocused
                                  ? const Color(0xFF8915E4)
                                  : Colors.grey,
                            ),
                            hintText: lang('typePassword', 'Password'),
                            hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: isPasswordFocused
                                        ? const Color(0xFF8915E4)
                                        : Colors.grey)),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF8915E4)),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  login();
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xFF8915E4),
                                    disabledBackgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.12),
                                    animationDuration:
                                        const Duration(seconds: 1),
                                    minimumSize: const Size(170, 47)),
                                child: Text(
                                  lang('btnLogin', 'Login'),
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  )),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword_page()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xFF8915E4),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    elevation: 0,
                                  ),
                                  child: Text(
                                      lang('forgotPw', 'Forgot password'),
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Divider(
                              color: Color(0xFF8915E4),
                              thickness: 1.5,
                              height: 15,
                            ),
                            Container(
                              color: currentTheme
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.background,
                              child: Text(
                                lang('anotherType', '    or Log in with    '),
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF8915E4)),
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                          },
                          child: const Icon(
                            Icons.g_mobiledata_rounded,
                            size: 100,
                            color: Color(0xFF8915E4),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                lang('quesForSignUp', 'Dont have an account?'),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupPage()));
                                },
                                child: Text(
                                  lang('signupNow', 'Sign up'),
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF8915E4),
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
