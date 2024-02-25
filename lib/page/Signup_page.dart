import 'package:calories_remake/page/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isEmailFocus = false;
  bool isUserNameFocus = false;
  bool isPassword = false;
  bool isPassword2 = false;
  TextEditingController _userName = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode _passwordFocus = FocusNode();
  TextEditingController _password2 = TextEditingController();
  FocusNode _passwordFocus2 = FocusNode();
  FocusNode _userNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  void initState() {
    super.initState();
    _userNameFocus.addListener(() {
      setState(() {
        isUserNameFocus = _userNameFocus.hasFocus;
      });
    });
    _emailFocus.addListener(() {
      setState(() {
        isEmailFocus = _emailFocus.hasFocus;
      });
    });
    _passwordFocus.addListener(() {
      setState(() {
        isPassword = _passwordFocus.hasFocus;
      });
    });
    _passwordFocus2.addListener(() {
      setState(() {
        isPassword2 = _passwordFocus2.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _userName.dispose();
    _userNameFocus.dispose();
    _emailFocus.dispose();
    _Email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    _password2.dispose();
    _passwordFocus2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 75, bottom: 15),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Text(
              'Fill the details & create your account',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _userName,
                focusNode: _userNameFocus,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: isUserNameFocus ? Color(0xFF8915E4) : Colors.grey,
                    ),
                    hintText: 'UserName',
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: isUserNameFocus
                                ? Color(0xFF8915E4)
                                : Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8915E4)))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _Email,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: isEmailFocus ? Color(0xFF8915E4) : Colors.grey,
                  ),
                  hintText: 'Email',
                  hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color:
                              isEmailFocus ? Color(0xFF8915E4) : Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8915E4))),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _password,
                focusNode: _passwordFocus,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: isPassword ? Color(0xFF8915E4) : Colors.grey,
                    ),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color:
                                isPassword ? Color(0xFF8915E4) : Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8915E4)))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _password2,
                focusNode: _passwordFocus2,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: isPassword2 ? Color(0xFF8915E4) : Colors.grey,
                    ),
                    hintText: 'again',
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color:
                                isPassword2 ? Color(0xFF8915E4) : Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8915E4)))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF8915E4),
                    onPrimary: Colors.white,
                    minimumSize: Size(150, 47)),
                child: Text(
                  'Sign up',
                  style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                )),
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
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(
                      '    or Sign in with    ',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Color(0xFF8915E4))),
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.g_mobiledata_rounded,
              size: 100,
              color: Color(0xFF8915E4),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_page()));
                      },
                      child: Text(
                        ' Login',
                        style: GoogleFonts.poppins(
                            color: Color(0xFF8915E4),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
