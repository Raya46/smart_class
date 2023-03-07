// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class SaklarPage extends StatefulWidget {
  const SaklarPage({Key? key}) : super(key: key);

  @override
  State<SaklarPage> createState() => _SaklarPageState();
}

class _SaklarPageState extends State<SaklarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saklar Page"),
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
