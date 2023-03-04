// ignore_for_file: file_names, implementation_imports, unnecessary_import, unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/widget/homepage/card.dart';
import 'package:flutter_smartclass/widget/homepage/homeAppbar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: Column(children: <Widget>[
                Expanded(flex: 2, child: HeaderCard(width: width)),
                Expanded(flex: 7, child: allCard(width: width)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class allCard extends StatefulWidget {
  const allCard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<allCard> createState() => _allCardState();
}

class _allCardState extends State<allCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text("Devices", style: bold20Prim()),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      lamp = !lamp;
                    });
                  },
                  child: cardLamp(width: widget.width)),
              InkWell(
                  onTap: () {
                    setState(() {
                      ac = !ac;
                    });
                  },
                  child: cardAc(width: widget.width)),
            ]),
          ],
        ),
      ),
      Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              curtain = !curtain;
                            });
                          },
                          child: cardCurtain(width: widget.width)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              switchs = !switchs;
                            });
                          },
                          child: cardSwitch(width: widget.width)),
                    ]),
              ],
            ),
          )),
      Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              board = !board;
                            });
                          },
                          child: cardBoard(width: widget.width)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              audio = !audio;
                            });
                          },
                          child: cardAudio(width: widget.width)),
                    ]),
              ],
            ),
          )),
      SizedBox(
        height: 50,
      )
    ]);
  }
}
