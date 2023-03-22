// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainRoom.dart';
import 'package:flutter_smartclass/services/mqtt_services.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class AccessPage extends StatefulWidget {
  MqttService2 mqttServices;
  AccessPage({super.key, 
  required this.mqttServices
  });

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  late List cardRoom = [];

  @override
  void initState() {
    try {
      fetchApi();
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  void fetchApi() async {
    String apiUrl = 'http://smartlearning.solusi-rnd.tech/api/rooms';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    setState(() {
      cardRoom = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: accesAppbar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              for (var data in cardRoom)
                RoomWidget(
                    width: width,
                    onTap: () {
                      if (data['available_devices'] == 0) {
                        print('not device connected');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomPage(
                                    roomName: '${data['name_room']}',
                                    uuid: '${data['uuid']}', 
                                    mqttServices: widget.mqttServices,
                                  )),
                        );
                      }
                    },
                    status: data['available_devices'] > 0
                        ? 'Connected'
                        : 'Not Connected',
                    roomName: '${data['name_room']}',
                    totalDevice: '${data['available_devices']}',
                    icon: data['name_room'].contains('TEDK')
                        ? Icons.electric_bolt
                        : data['name_room'].contains('TAV')
                            ? Icons.movie_sharp
                            : data['name_room'].contains('TFLM')
                                ? Icons.precision_manufacturing
                                : Icons.device_unknown)
            ],
          ),
        ),
      ),
    );
  }
}

class RoomWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String status;
  final String roomName;
  final String totalDevice;
  final IconData icon;
  const RoomWidget({
    Key? key,
    required this.width,
    required this.onTap,
    required this.status,
    required this.roomName,
    required this.totalDevice,
    required this.icon,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: width * 0.2,
                    width: width * 0.2,
                    child: Container(
                      color: primary,
                      child: Icon(
                        icon,
                        size: 36.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          status,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: med14prim50(),
                        ),
                      ],
                    ),
                    Text(
                      roomName,
                      style: bold20Prim(),
                    ),
                    Container(
                      width: 50,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: primary,
                      ),
                      child: Center(
                          child: Text(
                        totalDevice,
                        style: bold16White(),
                      )),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Ionicons.chevron_forward,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}
