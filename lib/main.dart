import 'package:flutter/material.dart';
import 'package:flutter_smartclass/mainNavigation.dart';
import 'package:flutter_smartclass/page/accessibility/room/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
    print("login:" + token.toString());
  runApp(MaterialApp(home: token == null ? LoginPage() : NavigationPage()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        primarySwatch: Colors.blue,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color.fromRGBO(51, 51, 51, 1),
        ),
      ),
      home: LoginPage(),
    );
  }
}
