// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CurtainPage extends StatefulWidget {
const CurtainPage({Key? key}) : super(key: key);

@override
State<CurtainPage> createState() => _CurtainPageState();
}

class _CurtainPageState extends State<CurtainPage> {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Curtain Page"),
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
