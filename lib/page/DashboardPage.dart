import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_class/component/AddDevicePage.dart';
import 'package:smart_class/global/Color.dart';
import 'package:smart_class/page/ControlPage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool lamp = false;
  bool curtains = false;
  bool ac = false;
  bool saklar = false;
  var temp;
  var weather;
  var location;
  var icon;
  late List arr;
  String? _selectedOption; // variabel untuk menyimpan opsi yang dipilih

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
      temp = result['main']['temp'];
      weather = result['weather'][0]['main'];
      location = result['name'];
      icon = result['weather'][0]['icon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'SmartClass',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ControlPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Divider(
                    height: height / 50,
                    color: Colors.transparent,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (location != null)
                                    Text(
                                      '$location',
                                      style: GoogleFonts.inter(fontSize: 16),
                                    ),
                                  if (weather == 'Clouds')
                                    const Icon(
                                      Icons.cloud,
                                      size: 24.0,
                                    )
                                  else if (weather == 'Thunderstorm')
                                    const Icon(
                                      Icons.thunderstorm,
                                      size: 24.0,
                                    ),
                                  if (icon != null)
                                    Image.network(
                                      "http://openweathermap.org/img/wn/$icon@2x.png",
                                      fit: BoxFit.contain,
                                      width: 100,
                                      height: 100,
                                    ),
                                  if (temp != null)
                                    Text(
                                      '${temp.toStringAsFixed(0)}\u00B0C',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (weather != null)
                                    Text(
                                      '$weather',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  Text(DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now())),
                                ],
                              ),
                              Divider(
                                height: height / 20,
                                color: Colors.transparent,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: width / 7,
                                        height: height / 16,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.location_history,
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: width / 7,
                                        height: height / 16,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [Text('+')],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  // Divider(
                  //   color: Colors.transparent,
                  // ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20.0,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DropdownButton(
                                      value:
                                          _selectedOption, // opsi yang dipilih saat ini
                                      items: [
                                        DropdownMenuItem(
                                            child: Text("Opsi 1"), value: "opsi1"),
                                        DropdownMenuItem(
                                            child: Text("Opsi 2"), value: "opsi2"),
                                        DropdownMenuItem(
                                            child: Text("Opsi 3"), value: "opsi3"),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          // mengubah variabel state _selectedOption saat opsi diubah
                                          _selectedOption = value;
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 7,
                                  child: AnimatedContainer(
                                    decoration: BoxDecoration(
                                        color: lamp ? base : disable,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    duration: const Duration(milliseconds: 400),
                                    child: SizedBox(
                                      width: width / 2.3,
                                      height: height / 4.83,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 16),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  Icons.lightbulb,
                                                  color: lamp ? bg : base,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Smart Lights",
                                                    style: GoogleFonts.inter(
                                                      color: lamp ? bg : base,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "4 Lamps",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      color: lamp ? bg : base,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Switch(
                                                        activeColor: bg,
                                                        value: lamp,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            lamp = value;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: width / 50,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 7,
                                  child: AnimatedContainer(
                                    decoration: BoxDecoration(
                                        color: curtains ? base : disable,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    duration: const Duration(milliseconds: 400),
                                    child: SizedBox(
                                      width: width / 2.3,
                                      height: height / 4.83,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 16),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  Icons.curtains,
                                                  color: curtains ? bg : base,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Smart Curtains",
                                                    style: GoogleFonts.inter(
                                                      color:
                                                          curtains ? bg : base,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "4 Curtains",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      color:
                                                          curtains ? bg : base,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Switch(
                                                        activeColor: bg,
                                                        value: curtains,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            curtains = value;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.transparent,
                              height: height / 90,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 7,
                                  child: AnimatedContainer(
                                    decoration: BoxDecoration(
                                        color: ac ? base : disable,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    duration: const Duration(milliseconds: 400),
                                    child: SizedBox(
                                      width: width / 2.3,
                                      height: height / 4.83,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 16),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  Icons.air,
                                                  color: ac ? bg : base,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Smart AC",
                                                    style: GoogleFonts.inter(
                                                      color: ac ? bg : base,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "2 AC",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      color: ac ? bg : base,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Switch(
                                                        activeColor: bg,
                                                        value: ac,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            ac = value;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: width / 50,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 7,
                                  child: AnimatedContainer(
                                    decoration: BoxDecoration(
                                        color: saklar ? base : disable,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    duration: const Duration(milliseconds: 400),
                                    child: SizedBox(
                                      width: width / 2.3,
                                      height: height / 4.83,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 16),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  Icons.switch_camera,
                                                  color: saklar ? bg : base,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Smart Saklar",
                                                    style: GoogleFonts.inter(
                                                      color: saklar ? bg : base,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "4 Saklar",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      color: saklar ? bg : base,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Switch(
                                                        activeColor: bg,
                                                        value: saklar,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            saklar = value;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
