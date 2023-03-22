import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/page/accessibility/room/audioPage.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainAc.dart';
import 'package:flutter_smartclass/services/mqtt_services.dart';
import 'package:flutter_smartclass/widget/roompage/widgetroom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  var roomName;
  var uuid;
  MqttService2 mqttServices;
  RoomPage(
      {super.key,
      required this.roomName,
      required this.uuid,
      required this.mqttServices});

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
  bool isSuccess = false;
  late List deviceList = [];
  late List cardList = [];
  late List updateList = [];
  bool isDeleting = false;
  final _formKey = GlobalKey<FormState>();
  String? vnameDevice, vtopic, vactive, vinactive;
  int? vid;
  String? uuidDelete;
  MqttService2 mqttServices = MqttService2();

  Future<void> deleteData(String uuid) async {
    setState(() {
      isDeleting = true;
    });

    final response = await http.delete(
        Uri.parse('http://smartlearning.solusi-rnd.tech/api/devices/$uuid'));
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

  void fetchApi() async {
    String apiUrl = 'http://smartlearning.solusi-rnd.tech/api/features';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        cardList = jsonDecode(response.body);
      });
    }
  }

  fetchUpdateDevice(int id) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String url = 'http://smartlearning.solusi-rnd.tech/api/devices/$id';
      http.Response response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name_feature": updateList[0]['name_feature'],
          "id_room": widget.uuid,
          "name_device": vnameDevice,
          "topic": vtopic,
          "active": vactive,
          "inactive": vinactive
        }),
      );
      var results = jsonDecode(response.body);
      if (results["success"] == true) {
        print('sukses');
      } else {
        print('gagal');
      }
    }
  }

  Future<dynamic> editDevice(String uuidDevice) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://smartlearning.solusi-rnd.tech/api/device/$uuidDevice/detail'),
      );
      setState(() {
        updateList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  void fetchDevice(String uuid, String? deviceType) async {
    String urlLampu =
        'http://smartlearning.solusi-rnd.tech/api/device/${widget.uuid}/$deviceType';
    http.Response response = await http.get(Uri.parse(urlLampu));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        deviceList = jsonDecode(response.body);
        isSuccess = true;
      });
    } else {
      setState(() {
        isSuccess = false;
      });
    }
    print('ini ${response.statusCode}');
    print('ini ${deviceList}');
  }

  Future<dynamic> modalBottomSheet(BuildContext context, String uuid, int id,
      String name, String topic, String active, String inactive) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        // backgroundColor: white,
        context: context,
        builder: (context) {
          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;
          // ignore: avoid_unnecessary_containers
          return SizedBox(
            height: screenHeight / 4.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.,
              children: [
                Divider(
                  indent: 150,
                  endIndent: 150,
                  height: 20,
                  thickness: 4,
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onPrimary: Colors.black,
                                elevation: 0),
                            onPressed: () async {
                              await editDevice(uuid);
                              editDevices(context, id, name, uuid, topic,
                                      active, inactive)
                                  .then((_) {
                                Navigator.pop(context);
                              });
                              print(id);
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text("Edit Devices",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onPrimary: Colors.black,
                                elevation: 0),
                            onPressed: () async {
                              await deleteData(uuid);
                              Navigator.pop(context);
                              // print(uuidDelete);
                              print(uuid);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text("Delete Devices",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> editDevices(BuildContext context, int id, String name,
      String uuid, String topic, String active, String inactive) {
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
                    'Edit Device',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    initialValue: updateList[0]['name_device'],
                    // controller: nameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      labelText: "Device Name",
                      hintText: "Enter the device name",
                      prefixIcon: Icon(Ionicons.tablet_landscape),
                    ),
                    validator: (value) => value!.length > 14
                        ? 'Device name must be less than 14 characters'
                        : null,
                    onSaved: (value) => vnameDevice = value ?? '',
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: updateList[0]['topic'],
                    // controller: topicController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      labelText: "Topic",
                      hintText: "Enter the topic name",
                      prefixIcon: Icon(Ionicons.layers),
                    ),
                    onSaved: (value) => vtopic = value ?? '',
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: updateList[0]['active'],
                          keyboardType: TextInputType.text,
                          // ignore: prefer_const_constructors
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            labelText: "Active",
                            hintText: "Message for Active",
                            prefixIcon:
                                // ignore: prefer_const_constructors
                                Icon(Icons.double_arrow),
                          ),
                          onSaved: (value) => vactive = value ?? '',
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: updateList[0]['inactive'],
                          // controller: inActiveController,
                          keyboardType: TextInputType.text,
                          // ignore: prefer_const_constructors
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            labelText: "Inactive",
                            hintText: "Message for Inactive",
                            prefixIcon:
                                // ignore: prefer_const_constructors
                                Icon(Icons.double_arrow),
                          ),
                          onSaved: (value) => vinactive = value ?? '',
                        ),
                      ),
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade800,
                    ),
                    onPressed: () async {
                      try {
                        await fetchUpdateDevice(id);
                        Navigator.pop(context);
                        // _submit();
                        print(id);
                        print(uuid);
                        // print(vnameDevice);
                        print(vtopic);
                        // print(vactive);
                        // print(vinactive);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Edit Device',
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
                          print('ini ${widget.uuid}');
                          print(data['topic']);
                          // print(deviceType);
                        });
                        try {
                          data['name_feature'] == '[POWER] LAMP'
                              ? fetchDevice(widget.uuid, 'power')
                              : data['name_feature'] == '[REMOTE] REMOTE'
                                  ? fetchDevice(widget.uuid,
                                      selectedCardText?.toLowerCase())
                                  : data['name_feature'] ==
                                          '[MONITORING] KWH MONITORING'
                                      ? fetchDevice(widget.uuid,
                                          selectedCardText?.toLowerCase())
                                      : data['name_feature'] ==
                                              '[SENSOR-TH] SENSOR SUHU'
                                          ? fetchDevice(widget.uuid,
                                              selectedCardText?.toLowerCase())
                                          : data['name_feature'] == '[POWER] AC'
                                              ? fetchDevice(
                                                  widget.uuid, 'power')
                                              : print('err');
                        } catch (e) {
                          print(e);
                        }
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
                          selectedCardText == '[POWER] LAMP'
                              ? InkWell(
                                  onLongPress: () {
                                    // deleteData('${data['uuid']}');
                                    // addDevices(context);
                                    // modalBottomSheet(context, '${data["uuid"]}', data['id'].toString());
                                    editDevice(data['uuid']);
                                    modalBottomSheet(
                                        context,
                                        data["uuid"],
                                        data["id"],
                                        data["name_device"].toString(),
                                        data["topic"].toString(),
                                        data["active"].toString(),
                                        data["inactive"].toString());
                                  },
                                  child: CardDevice(
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
                                    onTap: () {
                                      print('${data['uuid']}');
                                      print(data['topic']);
                                      widget.mqttServices.sendMessage(
                                          'Cikunir/lt2/stts2/sharp', 'ac');
                                    },
                                    status: data['name_device'] == ''
                                        ? 'Not Connected'
                                        : 'Connected',
                                  ),
                                )
                              : selectedCardText ==
                                          '[MONITORING] KWH MONITORING' &&
                                      isSuccess
                                  ? InkWell(
                                      onLongPress: () {
                                        modalBottomSheet(
                                            context,
                                            '${data["uuid"]}',
                                            data['id'],
                                            data["name_device"].toString(),
                                            data["topic"].toString(),
                                            data["active"].toString(),
                                            data["inactive"].toString());
                                      },
                                      child: CardDevice(
                                        icon: Ionicons.logo_electron,
                                        leadingButton: Switch(
                                          value: switchValue,
                                          onChanged: (value) {
                                            setState(() {
                                              switchValue = value;
                                            });
                                          },
                                        ),
                                        nameDevice: '${data['name_device']}',
                                        onTap: () {},
                                        status: data['name_device'] == ''
                                            ? 'Not Connected'
                                            : 'Connected',
                                      ),
                                    )
                                  : selectedCardText ==
                                              '[SENSOR TH] SENSOR SUHU' &&
                                          isSuccess
                                      ? InkWell(
                                          onLongPress: () {
                                            modalBottomSheet(
                                                context,
                                                '${data["uuid"]}',
                                                data['id'],
                                                data["name_device"].toString(),
                                                data["topic"].toString(),
                                                data["active"].toString(),
                                                data["inactive"].toString());
                                          },
                                          child: CardDevice(
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
                                            status: data['name_device'] == ''
                                                ? 'Not Connected'
                                                : 'Connected',
                                          ),
                                        )
                                      : selectedCardText == '[POWER] AC' &&
                                              isSuccess
                                          ? InkWell(
                                              onLongPress: () {
                                                modalBottomSheet(
                                                    context,
                                                    '${data["uuid"]}',
                                                    data['id'],
                                                    data["name_device"]
                                                        .toString(),
                                                    data["topic"].toString(),
                                                    data["active"].toString(),
                                                    data["inactive"]
                                                        .toString());
                                              },
                                              child: CardDevice(
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
                                                status:
                                                    data['name_device'] == ''
                                                        ? 'Not Connected'
                                                        : 'Connected',
                                              ),
                                            )
                                          : selectedCardText ==
                                                      '[POWER] REMOTE' &&
                                                  isSuccess
                                              ? InkWell(
                                                  onLongPress: () {
                                                    modalBottomSheet(
                                                        context,
                                                        '${data["uuid"]}',
                                                        data['id'],
                                                        data["name_device"]
                                                            .toString(),
                                                        data["topic"]
                                                            .toString(),
                                                        data["active"]
                                                            .toString(),
                                                        data["inactive"]
                                                            .toString());
                                                  },
                                                  child: CardDevice(
                                                    icon: Icons.control_camera,
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
                                                                AudioPage()),
                                                      );
                                                    },
                                                    status:
                                                        data['name_device'] ==
                                                                ''
                                                            ? 'Not Connected'
                                                            : 'Connected',
                                                  ),
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
