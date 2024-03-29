// ignore_for_file: file_names, implementation_imports, unnecessary_import, unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/global/textstyle.dart';
import 'package:flutter_smartclass/global/var/bool.dart';
import 'package:flutter_smartclass/services/mqtt_services.dart';
import 'package:flutter_smartclass/widget/homepage/card.dart';
import 'package:flutter_smartclass/widget/widgetAppbar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomePage extends StatefulWidget {
  var temp;
  var weather;
  var icon;
  final String uuid;
  HomePage({super.key, required this.uuid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mqttService = MqttService2();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppbar(context),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              child: Column(children: <Widget>[
                Flexible(
                  flex: 2,
                  child: HeaderCard(
                    width: width,
                    icon: '${widget.icon}',
                    temp: '${widget.temp}',
                    weather: '${widget.weather}', mqttServices: mqttService,
                  ),
                ),
                Flexible(
                    flex: 7,
                    child: allCard(
                      width: width,
                      varType: false, mqttServices: mqttService,
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
