import 'package:calories_remake/language/lang.dart';
import 'package:calories_remake/domain/usecases/create_account.dart';
import 'package:calories_remake/page/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  bool isEmailFocus = false;
  bool isUserNameFocus = false;
  bool isPassword = false;
  bool isPassword2 = false;
  TextEditingController _userName = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode _passwordFocus = FocusNode();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  TextEditingController _password2 = TextEditingController();
  FocusNode _passwordFocus2 = FocusNode();
  FocusNode _userNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  bool isSignUpSuc = false;

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

  void signUp() async {
    String email = _Email.text.trim();
    String password = _password.text.trim();
    String username = _userName.text.trim();
    String checkPassword = _password2.text.trim();
    bool isValidEmail(String email) {
      final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$");
      return emailRegex.hasMatch(email);
    }

    // Kiểm tra input có bị rỗng
    if (email.isEmpty ||
        password.isEmpty ||
        username.isEmpty ||
        checkPassword.isEmpty) {
      _showDialogCheckInput(
        'Đăng Ký thất bại',
        'Không được để trống thông tin.',
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return;
    }
    if (!isValidEmail(email)) {
      _showDialogCheckInput(
        'Đăng Ký thất bại',
        'Email phải có đuôi @gmail.com.',
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return;
    }
    if (password != checkPassword) {
      _showDialogCheckInput(
        'Đăng Ký thất bại',
        'Mật khẩu không chính xác.',
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return;
    }

    // Kiểm tra độ dài mật khẩu
    if (password.length < 6) {
      _showDialogCheckInput(
        'Đăng Ký thất bại',
        'Độ dài mật khẩu phải ít nhất 6 ký tự.',
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return; // Dừng hàm
    }

    try {
      int? isSignup = await createAccount(username, password, email);
      if (isSignup == 200) {
        setState(() {
          isSignUpSuc = true;
        });
        _showDialogCheckInput(
          'Đăng ký thành công',
          'Đi đến đăng nhập thou',
          const Icon(
            Icons.verified,
            color: Colors.green,
          ),
        );
      } else {
        _showDialogCheckInput(
          'Đăng Ký thất bại',
          'Vui lòng thử lại.',
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
        );
      }
    } catch (e) {
      _showDialogCheckInput(
        'Đăng Ký thất bại',
        'Đã xảy ra lỗi: $e',
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  void _showDialogCheckInput(String header, String body, Icon icon) {
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
                const SizedBox(width: 10),
                Text(
                  header,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Text(body),
            actions: isSignUpSuc
                ? <Widget>[
                    Center(
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF8915E4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login_page()));
                            },
                            child: const Text('OK'))),
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 75, bottom: 15),
                child: Text(
                  lang('signupText', 'Sign Up'),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Text(
              lang('textSignUp', 'Fill the details & create your account'),
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _userName,
                focusNode: _userNameFocus,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: isUserNameFocus
                          ? const Color(0xFF8915E4)
                          : Colors.grey,
                    ),
                    hintText: lang('userN', 'UserName'),
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: isUserNameFocus
                                ? const Color(0xFF8915E4)
                                : Colors.grey)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8915E4)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _Email,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: isEmailFocus ? const Color(0xFF8915E4) : Colors.grey,
                  ),
                  hintText: 'Email',
                  hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: isEmailFocus
                              ? const Color(0xFF8915E4)
                              : Colors.grey)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8915E4))),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _password,
                focusNode: _passwordFocus,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: isPassword ? const Color(0xFF8915E4) : Colors.grey,
                    ),
                    hintText: lang('typePassword', 'Password'),
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: isPassword
                                ? const Color(0xFF8915E4)
                                : Colors.grey)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8915E4)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
              child: TextField(
                controller: _password2,
                focusNode: _passwordFocus2,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color:
                          isPassword2 ? const Color(0xFF8915E4) : Colors.grey,
                    ),
                    hintText: lang('typePassword2', 'Verify Password'),
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: isPassword2
                                ? const Color(0xFF8915E4)
                                : Colors.grey)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8915E4)))),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  signUp();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF8915E4),
                    minimumSize: const Size(150, 47)),
                child: Text(
                  lang('signupText', 'Sign up'),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                )),
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
                    color: Theme.of(context).colorScheme.background,
                    child: Text(
                      lang('backSignIn', '    or Sign in with    '),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Color(0xFF8915E4))),
                    ),
                  )
                ],
              ),
            ),
            const Icon(
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
                            color: const Color(0xFF8915E4),
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
