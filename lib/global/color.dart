// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

// import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

const Color highlight = Color.fromRGBO(58, 129, 247, 1);
const Color highlight2 = Color.fromRGBO(210, 4, 253, 1);
const Color primary = Color.fromRGBO(51, 51, 51, 1);
const Color primary50 = Color.fromRGBO(51, 51, 51, 0.5);
const Color secondary = Color.fromRGBO(232, 232, 232, 1);
const Color secondary60 = Color.fromRGBO(232, 232, 232, 0.6);

LinearGradient LinearColor() {
  return LinearGradient(
        colors: [highlight, highlight2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
LinearGradient nullb() {
  return LinearGradient(
        colors: [primary, primary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
