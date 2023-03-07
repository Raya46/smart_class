import 'package:flutter/animation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

Color base = Color.fromRGBO(42, 50, 75, 1);
final Color bg = Color.fromRGBO(190, 196, 211, 1);
final Color disable = Color.fromRGBO(225, 229, 238, 1);
const Color textColor = Color.fromRGBO(42, 50, 75, 0.8);
const Color bgColor = Color.fromRGBO(252, 252, 252, 1);
const Color subText = Color.fromRGBO(0, 0, 0, 0.56);
const Color disableBaseColor = Color.fromRGBO(216, 226, 220, 1);
const Color disableBaseColor12 = Color.fromRGBO(0, 0, 0, 0.56);
const Color fieldBgColor = Color.fromRGBO(221, 225, 234, 1);
const Color lampOn = Color.fromRGBO(249, 203, 64, 1);
const Color powerOn = Color.fromRGBO(36, 169, 108, 1);
const Color redColor = Color.fromRGBO(214, 71, 51, 1);
final Color highlight = Color.fromRGBO(58, 129, 247, 1);
final Color highlight2 = Color.fromRGBO(210, 4, 253, 1);
final Color primary = Color.fromRGBO(51, 51, 51, 1);
final Color secondary = Color.fromRGBO(232, 232, 232, 1);

LinearGradient LinearColor() {
  return LinearGradient(
        colors: [highlight, highlight2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
LinearGradient LinearDown() {
  return LinearGradient(
        colors: [highlight, highlight2],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}