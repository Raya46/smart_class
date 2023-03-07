import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_class/global/Color.dart';
import 'package:smart_class/page/SettingPage.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Room 1',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height / 20,
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CircleList(),
                    CircleList(),
                    CircleList(),
                    CircleList(),
                    CircleList(),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  children: [
                    CardDevice(),
                    CardDevice(),
                    CardDevice(),
                    CardDevice(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class CircleList extends StatelessWidget {
  const CircleList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0,),
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle
          ),
          child: InkWell(
            onTap: () {
              
            },
            child: Center(
                child: Text(
              'Item 1',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
          ),
        ),
        Text(
          'Lightning',
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class CardDevice extends StatelessWidget {
  const CardDevice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10.0,),
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
                          'Status: ON',
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Panasonic AC',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
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