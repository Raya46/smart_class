import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/page/accessibility/room/audioPage.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainAc.dart';
import 'package:flutter_smartclass/widget/roompage/widgetroom.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  var roomName;
  var uuid;
  RoomPage({super.key, required this.roomName, required this.uuid});

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
  late List deviceList = [];

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

  void fetchDevice(String uuid, String? deviceType) async {
    String urlLampu =
        'http://smartlearning.solusi-rnd.tech/api/data-devices-$deviceType/${widget.uuid}';
    http.Response response = await http.get(Uri.parse(urlLampu));
    var result = jsonDecode(response.body);
    setState(() {
      deviceList = jsonDecode(response.body);
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
        leading: BackButton(
          color: Colors.black,
          // onPressed: () {
          //   print(widget.uuid);
          // },
        ),
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
                          // print(selectedCardIndex);
                          print(selectedCardText);
                          print(widget.uuid);
                        });
                        data['name_feature'] == 'LAMP'
                            ? fetchDevice(
                                widget.uuid, selectedCardText?.toLowerCase())
                            : data['name_feature'] == 'REMOTE'
                                ? fetchDevice(widget.uuid,
                                    selectedCardText?.toLowerCase())
                                : data['name_feature'] == 'KWH MONITORING'
                                    ? fetchDevice(widget.uuid,
                                        selectedCardText?.toLowerCase())
                                    : data['name_feature'] == 'SENSOR SUHU'
                                        ? fetchDevice(widget.uuid,
                                            selectedCardText?.toLowerCase())
                                        : data['name_feature'] == 'AC'
                                            ? fetchDevice(widget.uuid,
                                                selectedCardText?.toLowerCase())
                                            : print('err');
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
                        for (var data in deviceList)
                          selectedCardText == 'LAMP'
                              ? CardDevice(
                                  icon: Ionicons.bulb,
                                  leadingButton: Switch(
                                    value: lampValue,
                                    onChanged: (value) {
                                      setState(() {
                                        lampValue = value;
                                      });
                                    },
                                  ),
                                  nameDevice: '${data['name_device']}',
                                  onTap: () {},
                                  status: data['name_device'] == ''
                                      ? 'Not Connected'
                                      : 'Connected',
                                )
                              : selectedCardText == 'KWH MONITORING'
                                  ? CardDevice(
                                      icon: Ionicons.logo_electron,
                                      leadingButton: Switch(
                                        value: switchValue,
                                        onChanged: (value) {
                                          setState(() {
                                            switchValue = value;
                                          });
                                        },
                                      ),
                                      nameDevice:
                                          '${data['name_device']}',
                                      onTap: () {},
                                      status: data['name_device'] == ''
                                          ? 'Not Connected'
                                          : 'Connected',
                                    )
                                  : selectedCardText == 'SENSOR SUHU'
                                      ? CardDevice(
                                          icon: Ionicons.thermometer,
                                          leadingButton: Switch(
                                            value: switchValue,
                                            onChanged: (value) {
                                              setState(() {
                                                switchValue = value;
                                              });
                                            },
                                          ),
                                          nameDevice:
                                              '${data['name_device']}',
                                          onTap: () {},
                                          status:
                                              data['name_device'] == ''
                                                  ? 'Not Connected'
                                                  : 'Connected',
                                        )
                                      : selectedCardText == 'AC'
                                          ? CardDevice(
                                              icon: Ionicons.snow,
                                              leadingButton: const Icon(
                                                Ionicons.chevron_forward,
                                                size: 24.0,
                                              ),
                                              nameDevice:
                                                  '${data['name_device']}',
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AcPage()),
                                                );
                                              },
                                              status: data['name_device'] == ''
                                                  ? 'Not Connected'
                                                  : 'Connected',
                                            )
                                          : selectedCardText == 'REMOTE'
                                              ? CardDevice(
                                                  icon: Icons.control_camera,
                                                  leadingButton: const Icon(
                                                    Ionicons.chevron_forward,
                                                    size: 24.0,
                                                  ),
                                                  nameDevice: '${data['name_device']}',
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AudioPage()),
                                                    );
                                                  },
                                                  status: data['name_device'] == ''
                                                      ? 'Not Connected'
                                                      : 'Connected',
                                                )
                                              : Text('low')
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
