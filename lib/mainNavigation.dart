import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/page/accessibility/mainAccess.dart';
import 'package:flutter_smartclass/page/home/mainHome.dart';
import 'package:ionicons/ionicons.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const AccessPage(),
    const HomePage(),
    const AccessPage(),
  ];

  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: primary,),
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            selectedItemColor: const Color(0xff6200ee),
            unselectedItemColor: secondary,
            type: BottomNavigationBarType.shifting,
            onTap: (index) => setState(() {
                  currentIndex = index;
                }),
            items: _navBarItems),
      ),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Ionicons.home),
    activeIcon: Icon(Ionicons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Ionicons.accessibility),
    activeIcon: Icon(Ionicons.accessibility),
    label: 'Accessibility',
  ),
  BottomNavigationBarItem(
    icon: Icon(Ionicons.musical_notes),
    activeIcon: Icon(Ionicons.musical_notes),
    label: 'Audio',
  ),
  BottomNavigationBarItem(
    icon: Icon(Ionicons.person),
    activeIcon: Icon(Ionicons.person),
    label: 'Profile',
  ),
];
