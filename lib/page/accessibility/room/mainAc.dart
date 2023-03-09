// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AcPage extends StatefulWidget {
  const AcPage({Key? key}) : super(key: key);

  @override
  State<AcPage> createState() => _AcPageState();
}

class _AcPageState extends State<AcPage> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: primary),
        title: Text(
          "Panasonic AC",
          style: GoogleFonts.inter(color: primary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: const [],
      ),
      body: Container(
          child: Column(
        children: [
          Divider(
            height: MediaQuery.of(context).size.height / 30,
            color: Colors.transparent,
          ),
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Container(
                    decoration: BoxDecoration(
                        color: secondary60,
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 19.0,
                        right: 19.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Device Status',
                            style: GoogleFonts.inter(color: primary),
                          ),
                          Switch(
                            value: value,
                            onChanged: (value) {},
                          )
                        ],
                      ),
                    )),
              )),
          Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 95.0,
                      animation: true,
                      lineWidth: 15,
                      percent: 0.25,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '20°C',
                                style: GoogleFonts.chakraPetch(
                                  color: primary,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Celsius',
                                style: GoogleFonts.inter(
                                  color: primary,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      progressColor: primary,
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.speed,
                              color: Colors.white,
                              size: 55.0,
                            ),
                          ),
                        ),
                        Text('Speed', style: GoogleFonts.inter(color: primary),)
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.directions,
                              color: Colors.white,
                              size: 55.0,
                            ),
                          ),
                        ),
                        Text('Swing', style: GoogleFonts.inter(color: primary),)
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.air,
                              color: Colors.white,
                              size: 55.0,
                            ),
                          ),
                        ),
                        Text('Direction', style: GoogleFonts.inter(color: primary),)
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              )),
        ],
      )),
    );
  }
}
