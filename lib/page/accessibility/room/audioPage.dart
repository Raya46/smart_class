// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Audio",
          style: GoogleFonts.inter(color: primary),
        ),
        leading: BackButton(color: primary),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(children: []),
          )),
          Expanded(
              child: Container(
            child: Column(children: []),
          )),
          Expanded(
              child: Container(
            child: Column(children: []),
          )),
          Expanded(
              child: Container(
            child: Column(children: []),
          )),
        ],
      ),
    );
  }
}
