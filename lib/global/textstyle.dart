// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle bold24White() {
  return GoogleFonts.inter(
      color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
}

TextStyle bold16White() {
  return GoogleFonts.inter(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
}

TextStyle bold20White() {
  return GoogleFonts.inter(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
}
TextStyle bold20Highlight() {
  return GoogleFonts.inter(
      color: highlight, fontSize: 20, fontWeight: FontWeight.bold);
}

TextStyle med12Sec() {
  return GoogleFonts.inter(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300);
}
TextStyle med14Sec() {
  return GoogleFonts.inter(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
}
TextStyle bold20Prim() {
  return GoogleFonts.inter(
      color: primary, fontSize: 20, fontWeight: FontWeight.bold);
}
