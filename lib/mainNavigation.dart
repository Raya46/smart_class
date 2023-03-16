// ignore_for_file: file_names, unused_field, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/model/feature.dart';
import 'package:flutter_smartclass/model/room.dart';
import 'package:flutter_smartclass/page/accessibility/mainAccess.dart';
import 'package:flutter_smartclass/page/home/mainHome.dart';
import 'package:flutter_smartclass/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class NavigationPage extends StatefulWidget {
  final String uuid;
  const NavigationPage({Key? key, required this.uuid}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _formKey = GlobalKey<FormState>();
  late List<Feature> features;
  String? selectedFeature;
  String? nameFeature, nameDevice, topic, active, inactive;
  int currentIndex = 0;
  late List _classData = [];
  List<Widget>? screens;
  late List<Room> rooms = [];
  Room? _selectedItem;
  String? select;

  @override
  void initState() {
    super.initState();
    try {
      _fetchDataFeatures();
      _fetchDataClass();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchDataClass() async {
    try {
      final response = await http.get(
        Uri.parse('http://smartlearning.solusi-rnd.tech/api/data-rooms'),
      );
      setState(() {
        List<dynamic> jsonRooms = jsonDecode(response.body);
        _classData = jsonDecode(response.body);
        setState(() {
          rooms = jsonRooms.map((r) => Room.fromJson(r)).toList();
        });
        // Initialize screens after _classData has been fetched
        screens = [
          if (_classData.isNotEmpty) HomePage(uuid: _classData[0]['uuid']),
          AccessPage(),
        ];
      });
    } catch (e) {
      print("Exception: ${e}");
    }
  }

  Future<void> _fetchDataFeatures() async {
    try {
      final response = await http.get(
        Uri.parse('http://smartlearning.solusi-rnd.tech/api/data-features'),
      );
      setState(() {
        List<dynamic> jsonFeatures = jsonDecode(response.body);
        setState(() {
          features = jsonFeatures.map((f) => Feature.fromJson(f)).toList();
        });
      });
    } catch (e) {
      print("Exception: $e");
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        print(
            "name_feature: $selectedFeature, id_room: $select, name_device: $nameDevice, topic: $topic, active: $active, inactive: $inactive");
        final response = await http.post(
            Uri.parse(
                "http://smartlearning.solusi-rnd.tech/api/store-devices/"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "name_feature": selectedFeature,
              "id_room": select,
              "name_device": nameDevice,
              "topic": topic,
              "active": active,
              "inactive": inactive
            }));
        var results = jsonDecode(response.body);
        if (results["success"] == true) {
          try {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => NavigationPage(
                          uuid: '${_selectedItem?.uuid}',
                        )),
                (route) => false);
          } catch (e) {
            print(e);
          }
          print("berhasil insert data");
        } else {
          print("GAGAL INSERT DATABASE: ${response.statusCode}");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<dynamic> addDevices(
      BuildContext context, InputDecoration selectDecoration) {
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
                    'Add Device',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  DropdownButtonFormField<String>(
                    decoration: selectDecoration,
                    value: selectedFeature,
                    items: features
                        .map<DropdownMenuItem<String>>((Feature feature) {
                      return DropdownMenuItem<String>(
                        value: feature.name,
                        child: Text(
                          feature.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFeature = newValue;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: selectDecoration,
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
                  TextFormField(
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
                    onSaved: (value) => nameDevice = value ?? '',
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
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
                    onSaved: (value) => topic = value ?? '',
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
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
                          onSaved: (value) => active = value ?? '',
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
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
                          onSaved: (value) => inactive = value ?? '',
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
                    onPressed: () {
                      try {
                        _submit();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Save Device',
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

  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;
  InputDecoration selectDecoration = InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade200,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue.shade800,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: 'Pilih satu',
    hintStyle: TextStyle(
      fontSize: 14,
      color: Colors.grey,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(
        addDevice: () {
          try {
            addDevices(context, selectDecoration);
          } catch (e) {
            print(e);
          }
        },
        uuid: '${_classData[0]['uuid']}',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens?[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: primary,
        ),
        child: BottomNavigationBar(
            selectedLabelStyle: GoogleFonts.inter(),
            currentIndex: currentIndex,
            selectedItemColor: secondary,
            unselectedItemColor: secondary60,
            type: BottomNavigationBarType.shifting,
            onTap: (index) => setState(() {
                  currentIndex = index;
                }),
            items: _navBarItems),
      ),
    );
  }
}

class floatingButton extends StatelessWidget {
  final VoidCallback addDevice;
  final String uuid;
  const floatingButton({
    Key? key,
    required this.addDevice,
    required this.uuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: FloatingActionButton(
        backgroundColor: highlight,
        foregroundColor: secondary,
        onPressed: () {
          // print('${uuid}');
          addDevice();
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Ionicons.home),
    activeIcon: Icon(Ionicons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Ionicons.accessibility),
    activeIcon: Icon(Ionicons.accessibility),
    label: 'Accessibility',
  ),
];
