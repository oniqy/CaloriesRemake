import 'package:calories_remake/Language/lang.dart';
import 'package:calories_remake/page/Login_page.dart';
import 'package:calories_remake/theme/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitch = false;
  String? email;
  @override
  void initState() {
    super.initState();
    getemail();
  }
  void getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('UserEmail');
    });
  }

  void _ToggleTheme(bool value) {
    setState(() {
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      isSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 40),
                child: Text(
                  lang('profile', 'Profile'),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                ),
              ),
              Container(
                height: 160,
                width: 160,
                margin: const EdgeInsets.only(top: 22),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/huh_cat.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '$email',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary)),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1)),
                  child: Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(lang('switchAcc', 'Switch Account'),
                            style: const TextStyle(
                                color: Color(0xFFD479FF), fontSize: 15)),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.switch_account,
                          color: Color(0xFFD479FF),
                        )
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(right: 25, left: 25, top: 20),
                child: Divider(
                  height: 0.2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang('settingTx1', "language"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                    Transform.scale(
                        scale: 0.9,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 4, right: 1, top: 1, bottom: 1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1)),
                          child: DropdownButton<String>(
                            value: currentLang,
                            dropdownColor: Colors.grey,
                            focusColor: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                            items: [
                              DropdownMenuItem(
                                value: "vi",
                                child: Text(
                                  "Việt Nam",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "en",
                                child: Text(
                                  "English",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              )
                            ],
                            onChanged: (String? name) {
                              setState(() {
                                currentLang = name ?? "vi";
                              });
                            },
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Theme',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Switch(
                        value: isSwitch,
                        onChanged: _ToggleTheme,
                        activeColor:
                            Colors.grey.shade100, // Bright color for visibility
                        inactiveThumbColor: Colors
                            .grey.shade100, // Contrast color for visibility
                        activeTrackColor: Colors.grey
                            .shade700, // Light color for visibility of dark thumb image
                        inactiveTrackColor: Colors.grey.shade700,
                        activeThumbImage:
                            const AssetImage('assets/dark_mode.png'),
                        inactiveThumbImage:
                            const AssetImage('assets/light_mode.png'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(right: 25, left: 25),
                child: Divider(
                  height: 0.2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang('rsp', 'rp'),
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const Icon(Icons.comment)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lang("aboutUs", "About"),
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Transform.scale(scale: 1.3, child: const Icon(Icons.info))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang("settingTx2", 'Logout'),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login_page()));
                          },
                          child: const Icon(Icons.login_sharp)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
