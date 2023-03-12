import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/page/accessibility/room/audioPage.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainAc.dart';
import 'package:flutter_smartclass/widget/roompage/widgetroom.dart';
import 'package:ionicons/ionicons.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

int selectedCardIndex = -1;

class _RoomPageState extends State<RoomPage> {
  bool switchValue = false;
  bool lampValue = false;
  bool curtainsValue = false;

  List<CircleList> cardList = [
    CircleList(title: 'AC', onTap: () {}, icon: Ionicons.snow),
    CircleList(title: 'Lamp', onTap: () {}, icon: Ionicons.bulb),
    CircleList(title: 'Curtains', onTap: () {}, icon: Icons.curtains),
    CircleList(title: 'Switch', onTap: () {}, icon: Icons.switch_right),
    CircleList(title: 'Audio', onTap: () {}, icon: Icons.audiotrack),
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

  @override
  void initState(){
    super.initState();
    setState(() {
      selectedCardIndex = 0;
    });
  }

  move() {
    if (selectedCardIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AcPage()),
      );
    } else {
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
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cardList.length,
                itemBuilder: (context, index) {
                  return CircleList(
                    color: cardList[index].color,
                    title: cardList[index].title,
                    onTap: () {
                      setState(() {
                        selectedCardIndex = index;
                      });
                      print(selectedCardIndex);
                    },
                    icon: cardList[index].icon,
                    iconColor: cardList[index].iconColor,
                    isSelected: index == selectedCardIndex,
                  );
                },
              )),
              ),
          Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: cardDeviceList.length,
                  itemBuilder: (context, index) {
                    return CardDevice(
                      icon: cardDeviceList[index].icon,
                      status: cardDeviceList[index].status,
                      nameDevice: cardDeviceList[index].nameDevice,
                      onTap: selectedCardIndex == 0 || selectedCardIndex == 4
                          ? move
                          : cardDeviceList[index].onTap,
                      leadingButton:
                          selectedCardIndex == 0 || selectedCardIndex == 4
                              ? cardDeviceList[index].leadingButton
                              : switchterm()
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
