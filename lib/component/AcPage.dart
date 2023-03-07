// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class AcPage extends StatefulWidget {
  const AcPage({Key? key}) : super(key: key);

  @override
  State<AcPage> createState() => _AcPageState();
}

class _AcPageState extends State<AcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AC Page"),
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
