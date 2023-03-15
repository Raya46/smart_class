import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/page/accessibility/room/audioPage.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainAc.dart';
import 'package:flutter_smartclass/widget/roompage/widgetroom.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  var roomName;
  RoomPage({super.key, required this.roomName});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

int selectedCardIndex = -1;
String? selectedCardText;

class _RoomPageState extends State<RoomPage> {
  bool switchValue = false;
  bool lampValue = false;
  bool curtainsValue = false;
  bool isSelected = false;

  late List cardList = [
    // CircleList(title: 'AC', onTap: () {}, icon: Ionicons.snow),
    // CircleList(title: 'Lamp', onTap: () {}, icon: Ionicons.bulb),
    // CircleList(title: 'Curtains', onTap: () {}, icon: Icons.curtains),
    // CircleList(title: 'Switch', onTap: () {}, icon: Icons.switch_right),
    // CircleList(title: 'Audio', onTap: () {}, icon: Icons.audiotrack),
  ];

  List<CardDevice> cardDeviceList = [
    CardDevice(
      icon: Icons.device_unknown,
      status: 'unknown',
      nameDevice: 'unknown',
      onTap: () {},
      leadingButton: Icon(
        Ionicons.chevron_forward,
        size: 24.0,
      ),
    ),
  ];

  void fetchApi() async {
    String apiUrl = 'http://smartlearning.solusi-rnd.tech/api/data-features';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    setState(() {
      cardList = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      fetchApi();
      setState(() {
        selectedCardIndex = 0;
      });
    } catch (e) {
      print(e);
    }
  }

  move() {
    if (cardList[0]['name_feature'] == 'AC') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AcPage()),
      );
    } else if (cardList[0]['name_feature'] == 'REMOTE') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AudioPage()),
      );
    }
  }

  switchterm() {
    if (selectedCardIndex == 1) {
      return Switch(
          value: lampValue,
          onChanged: (value) {
            setState(() {
              lampValue = value;
            });
          });
    } else if (selectedCardIndex == 2) {
      return Switch(
          value: curtainsValue,
          onChanged: (value) {
            setState(() {
              curtainsValue = value;
            });
          });
    } else if (selectedCardIndex == 3) {
      return Switch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.roomName}',
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
            height: MediaQuery.of(context).size.height / 30,
          ),
          Expanded(
            flex: 1,
            child: Container(
                child: ListView(scrollDirection: Axis.horizontal, children: [
              Row(
                children: [
                  for (var data in cardList)
                    CircleList(
                      title: data['name_feature'],
                      onTap: () {
                        setState(() {
                          // selectedCardIndex = data['id'];
                          selectedCardIndex = data['id'];
                          selectedCardText = data['name_feature'];
                          print(selectedCardIndex);
                          print(selectedCardText);
                        });
                      },
                      icon: data['name_feature'] == 'LAMP'
                          ? Ionicons.bulb
                          : data['name_feature'] == 'AC'
                              ? Ionicons.snow
                              : data['name_feature'] == 'SENSOR SUHU'
                                  ? Ionicons.thermometer
                                  : data['name_feature'] == 'KWH MONITORING'
                                      ? Ionicons.logo_electron
                                      : Icons.control_camera_sharp,
                      color: isSelected ? primary : secondary,
                      iconColor: isSelected ? highlight : primary,
                      isSelected: data['id'] == selectedCardIndex,
                    )
                ],
              ),
            ])),
          ),
          Expanded(
              flex: 5,
              child: Container(
                  margin: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Container(
                    child: ListView(
                      children: [
                        // for (var data in cardList)
                        if (selectedCardText == 'LAMP')
                          CardDevice(
                            icon: Ionicons.bulb,
                            leadingButton: Switch(
                              value: lampValue,
                              onChanged: (value) {
                                setState(() {
                                  lampValue = value;
                                });
                              },
                            ),
                            nameDevice: '${cardList[0]['name_feature']}',
                            onTap: () {},
                            status: cardList[0]['name_feature'] == ''
                                ? 'Not Connected'
                                : 'Connected',
                          ),
                        if (selectedCardText == 'KWH MONITORING')
                          CardDevice(
                            icon: Ionicons.logo_electron,
                            leadingButton: Switch(
                              value: switchValue,
                              onChanged: (value) {
                                setState(() {
                                  switchValue = value;
                                });
                              },
                            ),
                            nameDevice: '${cardList[1]['name_feature']}',
                            onTap: () {},
                            status: cardList[1]['name_feature'] == ''
                                ? 'Not Connected'
                                : 'Connected',
                          ),
                        if (selectedCardText == 'SENSOR SUHU')
                          CardDevice(
                            icon: Ionicons.thermometer,
                            leadingButton: Switch(
                              value: switchValue,
                              onChanged: (value) {
                                setState(() {
                                  switchValue = value;
                                });
                              },
                            ),
                            nameDevice: '${cardList[2]['name_feature']}',
                            onTap: () {},
                            status: cardList[2]['name_feature'] == ''
                                ? 'Not Connected'
                                : 'Connected',
                          ),
                        if (selectedCardText == 'AC')
                          CardDevice(
                            icon: Ionicons.snow,
                            leadingButton: const Icon(
                            Ionicons.chevron_forward,
                            size: 24.0,
                            ),
                            nameDevice: '${cardList[3]['name_feature']}',
                            onTap: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AcPage()),
                              );
                            },
                            status: cardList[3]['name_feature'] == ''
                                ? 'Not Connected'
                                : 'Connected',
                          ),
                        if (selectedCardText == 'REMOTE')
                          CardDevice(
                            icon: Icons.control_camera,
                            leadingButton: const Icon(
                            Ionicons.chevron_forward,
                            size: 24.0,
                            ),
                            nameDevice: '${cardList[4]['name_feature']}',
                            onTap: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AudioPage()),
                              );
                            },
                            status: cardList[4]['name_feature'] == ''
                                ? 'Not Connected'
                                : 'Connected',
                          ), 
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
