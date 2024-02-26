import 'package:flutter/material.dart';
Map<String,String> _vi={
  "welcome": "Chào mừng bạn đến với Calories tracker",
  "typeEmail": "Nhập email của bạn",
  "typePassword": "Mật khẩu",
  "typePassword2": "Xác thực mật khẩu",
  "btnLogin": "Đăng nhập",
  "btnSignUp": "Đăng ký",
  "forgotPw": "Quên mật khẩu",
  "anotherType": "    hoặc đăng nhập với    ",
  "backSignIn": "    hoặc đăng ký với    ",
  "quesForSignUp": "Bạn chưa có tài khoản?",
  "signupNow": "Đăng ký ngay",
  "signupText": "Đăng ký",
  "signinText": "Đăng nhập",
  "textSignUp": "Nhập các thông tin bên dưới để tạo tài khoản",
  "userN": "Họ và tên",
  "signinNow": "Bạn đã có tài khoản?",
  "forgotPWtext": "Quên mật khẩu",
  "forgotPWtext2": "Nhập địa chỉ email liên kết\n với tài khoản này",
  "switchAcc":"Đổi tài khoản",
  "profile":"Thông tin cá nhân",
  "forgotPWbtn": "Gửi"};
Map<String,String> _en={
  "welcome": "Welcome to Calories tracker",
  "typeEmail": "Enter your email",
  "typePassword": "Password",
  "typePassword2": "Verify Password",
  "btnLogin": "Login",
  "btnSignUp": "Sign up",
  "forgotPw": "Forgot password",
  "anotherType": "    or Log in with    ",
  "backSignIn": "    or Sign in with    ",
  "quesForSignUp": "Dont have an account?",
  "signupNow": "Sign up",
  "signupText": "Sign up",
  "signinText": "Login",
  "textSignUp": "Fill the details & create your account",
  "userN": "Full name",
  "signinNow": "Already have an account?",
  "forgotPWtext": "Forgot Password",
  "forgotPWtext2": "Enter the email address associated\n with this account",
  "switchAcc":"Switch Account",
  "profile":"Profile",
  "forgotPWbtn": "Send"
};
String currentLang = "vi";
String lang(String key, String defaultString ){
  if(currentLang=="en")return _en[key]??defaultString;
  return _vi[key]??defaultString;
}
