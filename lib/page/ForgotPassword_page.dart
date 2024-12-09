import 'package:calories_remake/language/lang.dart';
import 'package:calories_remake/page/SendReuest_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_page.dart';

class ForgotPassword_page extends StatefulWidget {
  ForgotPassword_page({super.key});

  @override
  State<ForgotPassword_page> createState() => _ForgotPassword_pageState();
}

class _ForgotPassword_pageState extends State<ForgotPassword_page> {
  bool isEmailFocus = false;
  TextEditingController _email = TextEditingController();
  FocusNode _emailFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() {
      setState(() {
        isEmailFocus = _emailFocus.hasFocus;
      });
    });
  }

  void dispose() {
    _email.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 75, bottom: 15),
                  child: Text(
                    lang('forgotPWtext', 'Forgot Password'),
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ),
              ),
            ),
            Text(
              lang('forgotPWtext2',
                  'Enter the email address associated\n with this account'),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 55, right: 55),
              child: Image.asset('assets/ForgotPasswordImg.png'),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: TextField(
                controller: _email,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail,
                      color: isEmailFocus ? Color(0xFF8915E4) : Colors.grey,
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: isEmailFocus ? Color(0xFF8915E4) : Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8915E4)),
                    )),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SendRequestPage()));
              },
              child: Text(lang('forgotPWbtn', 'Send'),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500))),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF8915E4), minimumSize: Size(170, 47),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lang('signinNow', 'Already have an account?'),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_page()));
                      },
                      child: Text(
                        lang('signinText', ' Login'),
                        style: GoogleFonts.poppins(
                            color: Color(0xFF8915E4),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
