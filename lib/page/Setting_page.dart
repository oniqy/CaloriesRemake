import 'package:calories_remake/lang.dart';
import 'package:calories_remake/page/Login_page.dart';
import 'package:calories_remake/page/Questions.dart';
import 'package:calories_remake/theme/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Questionnarie.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitch = false;
  void _ToggleTheme(bool value) {
    setState(() {
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      isSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              lang('profile', 'Profile'),
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            margin: EdgeInsets.only(top: 40),
          ),
          Container(
            height: 160,
            width: 160,
            margin: EdgeInsets.only(top: 22),
            child: ClipRRect(
              child: Image.asset(
                'assets/huh_cat.jpg',
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'data',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1)),
              child: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(lang('switchAcc', 'Switch Account'),
                        style:
                            TextStyle(color: Color(0xFF8915E4), fontSize: 15)),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.switch_account,
                      color: Color(0xFF8915E4),
                    )
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.only(right: 25, left: 25, top: 20),
            child: Divider(
              height: 0.2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Theme',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Switch(
                    value: isSwitch,
                    onChanged: _ToggleTheme,
                    activeColor:
                        Colors.grey.shade100, // Bright color for visibility
                    inactiveThumbColor:
                        Colors.grey.shade100, // Contrast color for visibility
                    activeTrackColor: Colors.grey
                        .shade700, // Light color for visibility of dark thumb image
                    inactiveTrackColor: Colors.grey.shade700,
                    activeThumbImage: const AssetImage('assets/dark_mode.png'),
                    inactiveThumbImage:
                        const AssetImage('assets/light_mode.png'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Transform.scale(
                    scale: 1.3,
                    child: DropdownButton<String>(
                      value: currentLang,
                      items: const [
                        DropdownMenuItem(
                          value: "vi",
                          child: Text("vi"),
                        ),
                        DropdownMenuItem(
                          value: "en",
                          child: Text("en"),
                        )
                      ],
                      onChanged: (String? name) {
                        setState(() {
                          currentLang = name ?? "vi";
                        });
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_page()));
                      },
                      child: Icon(Icons.login_sharp)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
