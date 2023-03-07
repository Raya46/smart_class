// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
const CameraPage({Key? key}) : super(key: key);

@override
State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Camera Page"),
actions: const [],
),
body: SingleChildScrollView(
child: Container(
padding: const EdgeInsets.all(10.0),
child: Column(
children: [],
),
),
),
);
}
}
