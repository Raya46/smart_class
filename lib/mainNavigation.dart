// ignore_for_file: file_names, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/page/AddDevicePage.dart';
import 'package:flutter_smartclass/page/accessibility/mainAccess.dart';
import 'package:flutter_smartclass/page/home/mainHome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    const AccessPage(),
  ];

  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: primary,
        ),
        child: BottomNavigationBar(
            selectedLabelStyle: GoogleFonts.inter(),
            currentIndex: currentIndex,
            selectedItemColor: secondary,
            unselectedItemColor: secondary60,
            type: BottomNavigationBarType.shifting,
            onTap: (index) => setState(() {
                  currentIndex = index;
                }),
            items: _navBarItems),
      ),
    );
  }
}

class floatingButton extends StatelessWidget {
  const floatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
        child: FloatingActionButton(
          backgroundColor: highlight,
          foregroundColor: secondary,
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDevicePage()),
            );
          },
          child: const Icon(Icons.add,size: 30,),
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
];
