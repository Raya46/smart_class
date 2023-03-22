// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/model/feature.dart';
import 'package:flutter_smartclass/model/room.dart';
import 'package:flutter_smartclass/services/data_mqtt_services.dart';
import 'package:flutter_smartclass/services/mqtt_services.dart';
import 'package:flutter_smartclass/services/user_services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class HeaderCard extends StatefulWidget {
  var temp;
  var weather;
  var icon;
  MqttService2 mqttServices;

  HeaderCard(
      {Key? key,
      required this.width,
      this.weather,
      this.icon,
      this.temp,
      required this.mqttServices})
      : super(key: key);

  final double width;

  @override
  State<HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<HeaderCard> {
  var temp;
  var weather;
  var icon;
  bool _locationPermissionRequested = false;
  late List device = [];
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    try {
      _getLocationPermission();
      getCurrentLocation();
      widget.mqttServices.connectAndSubscribe().then((_) {
        subscription = widget.mqttServices.client2!.updates!.listen(receive);
      });
    } catch (e) {
      print(e);
    }
  }

  void receive(List<MqttReceivedMessage<MqttMessage?>>? event) {
    final recMess = event![0].payload as MqttPublishMessage;
    final String pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    setState(() {
      widget.mqttServices.temp = pt;
    });
    DataStorage.data = jsonDecode(widget.mqttServices.temp);
    print(DataStorage.data['V']);
  }

  Future<void> _getLocationPermission() async {
    if (_locationPermissionRequested) {
      return;
    }

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
      try {
        temp = result['main']['temp'];
        weather = result['weather'][0]['main'];
        icon = result['weather'][0]['icon'];
      } catch (e) {
        print(e);
      }
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
                              if (temp != null)
                                Text('${temp?.toStringAsFixed(0) ?? ''}\u00B0C',
                                    style: bold24White()),
                            ],
                          )),
                      const SizedBox(height: 8),
                      if (weather != null)
                        Text(weather?.toString() ?? '', style: bold16White()),
                      const SizedBox(height: 3),
                      Text(
                        DateFormat('dd MMMM yyyy').format(DateTime.now()),
                        style: med12Sec(),
                      ),
                    ]),
                if (icon != null)
                  Image.network(
                    "http://openweathermap.org/img/wn/$icon@2x.png",
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
                        '${DataStorage.data['C']}',
                        overflow: TextOverflow.ellipsis,
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

class cardDeviceBoard extends StatefulWidget {
  cardDeviceBoard({
    super.key,
    required this.width,
    required this.deviceType,
    required this.deviceValue,
    required this.varType,
    required this.iconData,
  });

  IconData iconData;
  bool varType;
  String deviceType;
  String deviceValue;
  double width;

  @override
  State<cardDeviceBoard> createState() => _cardDeviceBoardState();
}

class _cardDeviceBoardState extends State<cardDeviceBoard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: widget.varType ? primary : secondary,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        duration: const Duration(milliseconds: 400),
        child: SizedBox(
          height: widget.width / 2.35,
          width: widget.width / 2.35,
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
                        backgroundColor:
                            widget.varType ? Colors.white : primary,
                        child: Icon(
                          widget.iconData,
                          color: widget.varType ? highlight : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${widget.deviceType}',
                          overflow: TextOverflow.ellipsis,
                          style: widget.varType
                              ? bold16Highlight()
                              : bold16Prim()),
                      Text(
                        "${widget.deviceValue} Devices",
                        style: GoogleFonts.inter(
                            color: widget.varType ? Colors.white : primary,
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
                        width: widget.width / 7.5,
                        height: widget.width * 0.08,
                        value: widget.varType,
                        onToggle: (value) {
                          setState(() {
                            widget.varType = value;
                            print(widget.varType);
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

class allCard extends StatefulWidget {
  MqttService2 mqttServices;
  allCard(
      {super.key,
      required this.width,
      required this.varType,
      required this.mqttServices});
  bool varType;

  final double width;

  @override
  State<allCard> createState() => _allCardState();
}

class _allCardState extends State<allCard> {
  late List feature = [];
  bool isLoading = false;
  List<Room> rooms = [];
  Room? _selectedItem;
  late List _classData = [];
  late List detailDevices = [];
  String? selectedFeature;
  final _formKey = GlobalKey<FormState>();
  late List<Feature> features;
  String? select;
  String? selectClass;
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    try {
      fetchDataFeatures();
      _fetchDataClass();
      fetchApiRoom().then((items) {
        setState(() {
          rooms = items;
          _selectedItem = rooms[0];
        });
      });
    } catch (e) {
      print(e);
    }
  }

   Future<void> deleteData(String uuid) async {
    setState(() {
      isDeleting = true;
    });

    final response = await http.delete(Uri.parse('http://smartlearning.solusi-rnd.tech/api/devices/$uuid'));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete item')),
      );
    }

    setState(() {
      isDeleting = false;
    });
  }

  Future<dynamic> deleteDevice(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      isScrollControlled: true, // tambahkan ini agar modal dapat di-scroll
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // tambahkan SingleChildScrollView
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // tambahkan ini agar padding bawah disesuaikan dengan keyboard
                left: 22.0,
                right: 22.0,
                top: 22.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Delete Device',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30.0),
                   DropdownButtonFormField<String>(
                    value: select,
                    items: rooms.map<DropdownMenuItem<String>>((Room room) {
                      return DropdownMenuItem<String>(
                        value: room.uuid,
                        child: Text(
                          '${room.name}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        select = newValue;
                      });
                      print(select);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade800,
                    ),
                    onPressed: () {
                      try {
                        // _submit();
                        deleteData('$select');
                        // print(select);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Delete Device',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future<void> fetchDataFeatures() async {
    try {
      final response = await http.get(
        Uri.parse('http://smartlearning.solusi-rnd.tech/api/features'),
      );
      setState(() {
        List<dynamic> jsonFeatures = jsonDecode(response.body);
        isLoading = true;
        feature = jsonDecode(response.body);
        setState(() {
          features = jsonFeatures.map((f) => Feature.fromJson(f)).toList();
        });
      });
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> _fetchDataClass() async {
    try {
      final response = await http.get(
        Uri.parse('http://smartlearning.solusi-rnd.tech/api/rooms'),
      );
      setState(() {
        _classData = jsonDecode(response.body);
      });
    } catch (e) {
      print("Exception: $e");
    }
  }
  Future<void> fetchDetail(String uuid) async {
    try {
      final response = await http.get(
        Uri.parse('http://smartlearning.solusi-rnd.tech/api/device/$uuid/power'),
      );
      setState(() {
        detailDevices = jsonDecode(response.body);
        print(detailDevices);
      });
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Devices", style: bold20Prim()),
                DropdownButton(
                    value: selectClass,
                    items: rooms.map<DropdownMenuItem<String>>((Room room) {
                      return DropdownMenuItem<String>(
                        value: room.uuid,
                        child: Text(
                          '${room.name}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectClass = newValue;
                      });
                      fetchDetail('$selectClass');
                      print(selectClass);
                    },
                  ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Wrap(spacing: 10.0, runSpacing: 10.0, children: [
              for (var data in detailDevices)
                InkWell(
                  onTap: () {
                    setState(() {
                      data['name_feature'] == 'LAMP'
                          ? lamp = !lamp
                          : data['name_feature'] == 'AC'
                              ? ac = !ac
                              : data['name_feature'] == 'SENSOR SUHU'
                                  ? switchAc = !switchAc
                                  : data['name_feature'] == 'KWH MONITORING'
                                      ? curtain = !curtain
                                      : switchBoard = !switchBoard;
                    });
                    widget.mqttServices.sendMessage('Cikunir/lt2/stts2/sharp', 'Started');
                  },
                  child: cardDeviceBoard(
                    deviceType: "${data['name_device']}",
                    deviceValue: _selectedItem?.name == 'TEDK'
                        ? "${detailDevices.length}"
                        : _selectedItem?.name == 'TAV1'
                            ? "${detailDevices.length}"
                            : _selectedItem?.name == 'TAV2'
                                ? "${detailDevices.length}"
                                : _selectedItem?.name == 'TFLM'
                                    ? "${detailDevices.length}"
                                    : '',
                    width: widget.width,
                    varType: data['name_feature'] == 'LAMP'
                        ? lamp
                        : data['name_feature'] == 'AC'
                            ? ac
                            : data['name_feature'] == 'SENSOR SUHU'
                                ? switchAc
                                : data['name_feature'] == 'KWH MONITORING'
                                    ? curtain
                                    : switchBoard,
                    iconData: data['name_feature'] == 'LAMP'
                        ? Ionicons.bulb
                        : data['name_feature'] == 'AC'
                            ? Ionicons.snow
                            : data['name_feature'] == 'SENSOR SUHU'
                                ? Ionicons.thermometer
                                : data['name_feature'] == 'KWH MONITORING'
                                    ? Ionicons.logo_electron
                                    : Icons.control_camera_sharp,
                  ),
                ),
            ]),
          ],
        ),
      ),
      const SizedBox(
        height: 50,
      )
    ]);
  }
}
