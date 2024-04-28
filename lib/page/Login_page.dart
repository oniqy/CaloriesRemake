import 'package:calories_remake/Language/lang.dart';
import 'package:calories_remake/page/ForgotPassword_page.dart';
import 'package:calories_remake/page/Signup_page.dart';
import 'package:calories_remake/theme/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Questionnarie.dart';
import 'Questions.dart';

class Login_page extends StatefulWidget {
  Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  bool currentTheme = false;
  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  bool selected = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  void setTheme() {
    setState(() {
      currentTheme = !currentTheme;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set up the focus listener here
    _emailFocus.addListener(() {
      setState(() {
        // Update isPress based on whether the TextField has focus
        isEmailFocused = _emailFocus.hasFocus;
      });
    });
    _passwordFocus.addListener(() {
      setState(() {
        isPasswordFocused = _passwordFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
  void click(){
    GestureDetector(
      onTap: (){
        setState(() {
          selected=!selected;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 75),
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
                    margin: EdgeInsets.only(top: 5, left: 55, right: 55),
                    child: Image.asset('assets/backgroudLogin.png'),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: TextField(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          controller: _email,
                          focusNode: _emailFocus,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: isEmailFocused
                                  ? Color(0xFF8915E4)
                                  : Colors.grey,
                            ),
                            hintText: lang('typeEmail', 'Enter your email'),
                            hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: isEmailFocused
                                        ? Color(0xFF8915E4)
                                        : Colors.grey)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF8915E4)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: TextField(
                          controller: _password,
                          focusNode: _passwordFocus,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: isPasswordFocused
                                  ? Color(0xFF8915E4)
                                  : Colors.grey,
                            ),
                            hintText: lang('typePassword', 'Password'),
                            hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: isPasswordFocused
                                        ? Color(0xFF8915E4)
                                        : Colors.grey)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF8915E4)),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  click();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Questionnaire(questions: [
                                                Question(
                                                    questionText: lang(
                                                        'questionText1',
                                                        'What are your goals?'),
                                                    subText: lang('subText1',
                                                        'Select all that apply')),
                                                Question(
                                                    questionText: lang(
                                                        'questionText2',
                                                        'How old are you?'),
                                                    subText: lang('subText2',
                                                        'This help us create your personalized plan')),
                                                Question(
                                                    questionText: lang(
                                                        'questionText3',
                                                        'How tall are you?'),
                                                    subText: lang('subText3',
                                                        'This help us create your personalized plan')),
                                                Question(
                                                    questionText: lang(
                                                        'questionText4',
                                                        'What is your latest weight?'),
                                                    subText: lang('subText4',
                                                        'You can update your weight anytime')),
                                              ])));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF8915E4),
                                    disabledBackgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                                    onPrimary: Colors.white,
                                    animationDuration: Duration(seconds: 1),
                                    minimumSize: Size(170, 47)),
                                child: Text(
                                  lang('btnLogin', 'Login'),
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  )),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword_page()));
                                  },
                                  child: Text(lang('forgotPw', 'Forgot password'),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    onPrimary: Color(0xFF8915E4),
                                    elevation: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(
                              color: Color(0xFF8915E4),
                              thickness: 1.5,
                              height: 15,
                            ),
                            Container(
                              color: currentTheme
                                  ? Colors.black
                                  : Theme.of(context).scaffoldBackgroundColor,
                              child: Text(
                                lang('anotherType', '    or Log in with    '),
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        TextStyle(color: Color(0xFF8915E4)),
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
                          child: Icon(
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
                                      textStyle: TextStyle(
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
