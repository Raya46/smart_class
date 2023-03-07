// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_class/global/Color.dart';
import 'package:smart_class/page/ControlPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Setting Page",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: Column(
              children: [
                Divider(color: Colors.transparent,),
                CardRoom(),
                CardRoom(),
                CardRoom(),
                CardRoom(),
              ],
            ),
          ),
        ));
  }
}

class CardRoom extends StatelessWidget {
  const CardRoom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ControlPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12.0,),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 6,
                    decoration: BoxDecoration(
                        color: base,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(20))),
                    child: const Icon(
                      Icons.lightbulb,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connected',
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Room 1',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        Divider(
                            height: MediaQuery.of(context).size.height *
                                0.01),
                        Container(
                          width:
                              MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                              color: base,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5))),
                          child: Text(
                            '4',
                            textAlign: TextAlign.center,
                            style:
                                GoogleFonts.inter(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 24.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
