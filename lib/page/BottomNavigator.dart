import 'package:calories_remake/page/Exercise_page.dart';
import 'package:calories_remake/page/Home_page.dart';
import 'package:calories_remake/page/MenuFood.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../theme/ThemeProvider.dart';
import 'Chart_page.dart';
import 'Setting_page.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int currentPage = 0;

  void NavigatorPage(int indexPage) {
    setState(() {
      currentPage = indexPage;
    });
  }

  final _page = [
    const HomePage(),
    const MenuFood(),
    const Exercise_page(),
    ChartPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: Provider.of<ThemeProvider>(context).themeData,
      home: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _page[currentPage],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GNav(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                gap: 7,
                curve: Curves.easeInToLinear,
                onTabChange: NavigatorPage,
                backgroundColor: Colors.transparent,
                tabBackgroundColor: const Color.fromRGBO(188, 124, 237, 0.2),
                activeColor: const Color(0xFF8915E4),
                color: Theme.of(context).colorScheme.primary,
                selectedIndex: currentPage,
                tabs: const [
                  GButton(
                    icon: Icons.home_filled,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.receipt,
                    text: 'Menu',
                  ),
                  GButton(
                    icon: Icons.run_circle,
                    text: 'Exercise',
                  ),
                  GButton(
                    icon: Icons.insert_chart,
                    text: 'Chart',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Setting',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
