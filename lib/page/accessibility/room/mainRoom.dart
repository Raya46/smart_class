import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainAc.dart';
import 'package:flutter_smartclass/widget/roompage/widgetroom.dart';
import 'package:ionicons/ionicons.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool value = false;
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
            height: MediaQuery.of(context).size.height / 30,
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CircleList(
                      icon: Icons.severe_cold,
                      onTap: () {},
                      title: 'AC',
                    ),
                    CircleList(
                      icon: Icons.lightbulb,
                      onTap: () {},
                      title: 'Lamp',
                    ),
                    CircleList(
                      icon: Icons.curtains,
                      onTap: () {},
                      title: 'Curtains',
                    ),
                    CircleList(
                      icon: Icons.switch_right,
                      onTap: () {},
                      title: 'Switch',
                    ),
                    CircleList(
                      icon: Icons.audiotrack,
                      onTap: () {},
                      title: 'Audio',
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                ),
                child: Column(
                  children: [
                    CardDevice(
                      icon: Icons.severe_cold,
                      nameDevice: 'Panasonic',
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AcPage()),
                        );
                      },
                      status: 'off',
                      leadingButton: const Icon(
                        Ionicons.chevron_forward,
                        size: 24.0,
                      ),
                    ),
                    CardDevice(
                      icon: Icons.severe_cold,
                      nameDevice: 'Samsung',
                      onTap: () {},
                      status: 'on',
                      leadingButton: 
                      Switch(
                        value: value,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
