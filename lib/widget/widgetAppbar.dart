import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/page/accessibility/profilePage.dart';
import 'package:flutter_smartclass/page/accessibility/room/loginPage.dart';
import 'package:flutter_smartclass/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';


AppBar homeAppbar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearColor().createShader(bounds);
      },
      child: Text(
        'SmartClass',
        style: GoogleFonts.chakraPetch(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: secondary,
          child: IconButton(
            icon: Icon(
              Icons.person_rounded,
              color: primary,
            ),
            onPressed: () {
              logout().then((value) => {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false)
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfilePage1()),
              // );
            },
          ),
        ),
      ),
    ],
  );
}


AppBar accesAppbar() {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
        'Accesibility',
        style: bold24Prim()
      ),
    
  );
}

AppBar roomAppbar() {
  return AppBar(
    leading: BackButton(color: primary),
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
        'Accesibility',
        style: bold16Prim()
      ),
    
  );
}

