// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class HeaderCard extends StatefulWidget {
  var temp;
  var weather;
  var icon;
  HeaderCard(
      {Key? key, required this.width, this.weather, this.icon, this.temp})
      : super(key: key);

  final double width;

  @override
  State<HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<HeaderCard> {
  var temp;
  var weather;
  var icon;
  late List component = [];

  @override
    void initState() {
    super.initState();
    _getLocationPermission();
    getCurrentLocation();
  }

  Future<void> _getLocationPermission() async {
    final PermissionStatus permission =
        await Permission.locationWhenInUse.status;

    if (permission == PermissionStatus.denied) {
      final PermissionStatus permissionStatus =
          await Permission.locationWhenInUse.request();

      if (permissionStatus != PermissionStatus.granted) {
        throw Exception('Location permission is denied');
      }
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getWeatherData(position.latitude, position.longitude);
  }

  Future<void> getWeatherData(double lat, double lon) async {
    String apiKey = "ca2391bde7dc6773060f0709b7272a48";
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    setState(() {
      component = jsonDecode(response.body);
      temp = result['main']['temp'];
      weather = result['weather'][0]['main'];
      icon = result['weather'][0]['icon'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: primary,
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearColor().createShader(bounds);
                          },
                          child: Column(
                            children: [
                              if (component[0]['main']['temp'] != null)
                                Text('${component[0]['main']['temp']?.toStringAsFixed(0) ?? ''}\u00B0C',
                                    style: bold24White()),
                            ],
                          )),
                      const SizedBox(height: 8),
                      if (component[0]['weather'][0]['main'] != null)
                        Text(component[0]['weather'][0]['main']?.toString() ?? '', style: bold16White()),
                      const SizedBox(height: 3),
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: med12Sec(),
                      ),
                    ]),
                if (icon != null)
                  Image.network(
                    "http://openweathermap.org/img/wn/${component[0]['weather'][0]['icon']}@2x.png",
                    fit: BoxFit.contain,
                    width: 100,
                    height: 100,
                  ),
              ]),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Indor Temp',
                        style: med14Sec(),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '20°C',
                        style: bold16White(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Indor Temp',
                        style: med14Sec(),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '10%',
                        style: bold16White(),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cardLamp extends StatefulWidget {
  const cardLamp({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<cardLamp> createState() => _cardLampState();
}

class _cardLampState extends State<cardLamp> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: lamp ? primary : secondary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: width / 2.35,
          width: width / 2.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: lamp ? Colors.white : primary,
                        child: Icon(
                          Ionicons.bulb,
                          color: lamp ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Smart Lamp',
                          style: lamp ? bold16Highlight() : bold16Prim()),
                      Text(
                        "4 Lamps",
                        style: GoogleFonts.inter(
                            color: lamp ? Colors.white : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlutterSwitch(
                        activeToggleColor: highlight,
                        toggleColor: secondary,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        width: width / 7.5,
                        height: width * 0.08,
                        value: lamp,
                        onToggle: (value) {
                          setState(() {
                            lamp = value;
                          });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class cardAc extends StatefulWidget {
  const cardAc({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<cardAc> createState() => _cardAcState();
}

class _cardAcState extends State<cardAc> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: ac ? primary : secondary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: width / 2.35,
          width: width / 2.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: ac ? Colors.white : primary,
                        child: Icon(
                          Ionicons.snow,
                          color: ac ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Smart Ac',
                          style: ac ? bold16Highlight() : bold16Prim()),
                      Text(
                        "4 Devices",
                        style: GoogleFonts.inter(
                            color: ac ? Colors.white : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlutterSwitch(
                        activeToggleColor: highlight,
                        toggleColor: secondary,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        width: width / 7.5,
                        height: width * 0.08,
                        value: ac,
                        onToggle: (value) {
                          setState(() {
                            ac = value;
                            ac = value;
                          });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class cardCurtain extends StatefulWidget {
  const cardCurtain({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<cardCurtain> createState() => _cardCurtainState();
}

class _cardCurtainState extends State<cardCurtain> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: curtain ? primary : secondary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: width / 2.35,
          width: width / 2.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: curtain ? Colors.white : primary,
                        child: Icon(
                          Icons.curtains_closed_rounded,
                          color: curtain ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Smart Curtain',
                          style: curtain ? bold16Highlight() : bold16Prim()),
                      Text(
                        "4 Devices",
                        style: GoogleFonts.inter(
                            color: curtain ? Colors.white : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlutterSwitch(
                        activeToggleColor: highlight,
                        toggleColor: secondary,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        width: width / 7.5,
                        height: width * 0.08,
                        value: curtain,
                        onToggle: (value) {
                          setState(() {
                            curtain = value;
                            curtain = value;
                          });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class cardSwitch extends StatefulWidget {
  const cardSwitch({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<cardSwitch> createState() => _cardSwitchState();
}

class _cardSwitchState extends State<cardSwitch> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: switchs ? primary : secondary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: width / 2.35,
          width: width / 2.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: switchs ? Colors.white : primary,
                        child: Icon(
                          Ionicons.toggle,
                          color: switchs ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Smart Switch',
                          style: switchs ? bold16Highlight() : bold16Prim()),
                      Text(
                        "4 Devices",
                        style: GoogleFonts.inter(
                            color: switchs ? Colors.white : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlutterSwitch(
                        activeToggleColor: highlight,
                        toggleColor: secondary,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        width: width / 7.5,
                        height: width * 0.08,
                        value: switchs,
                        onToggle: (value) {
                          setState(() {
                            switchs = value;
                          });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class cardBoard extends StatefulWidget {
  const cardBoard({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<cardBoard> createState() => _cardBoardState();
}

class _cardBoardState extends State<cardBoard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: board ? primary : secondary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: width / 2.35,
          width: width / 2.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: board ? Colors.white : primary,
                        child: Icon(
                          Ionicons.tv,
                          color: board ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Smart Board',
                          style: board ? bold16Highlight() : bold16Prim()),
                      Text(
                        "1 Devices",
                        style: GoogleFonts.inter(
                            color: board ? Colors.white : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlutterSwitch(
                        activeToggleColor: highlight,
                        toggleColor: secondary,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        width: width / 7.5,
                        height: width * 0.08,
                        value: board,
                        onToggle: (value) {
                          setState(() {
                            board = value;
                          });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class cardAudio extends StatefulWidget {
  const cardAudio({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<cardAudio> createState() => _cardAudioState();
}

class _cardAudioState extends State<cardAudio> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: audio ? primary : secondary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: width / 2.35,
          width: width / 2.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: audio ? Colors.white : primary,
                        child: Icon(
                          Ionicons.musical_notes,
                          color: audio ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Smart Audio',
                          style: audio ? bold16Highlight() : bold16Prim()),
                      Text(
                        "4 Devices",
                        style: GoogleFonts.inter(
                            color: audio ? Colors.white : primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlutterSwitch(
                        activeToggleColor: highlight,
                        toggleColor: secondary,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        width: width / 7.5,
                        height: width * 0.08,
                        value: audio,
                        onToggle: (value) {
                          setState(() {
                            audio = value;
                          });
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
