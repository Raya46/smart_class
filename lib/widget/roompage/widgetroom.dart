import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/color.dart';
import 'package:flutter_smartclass/page/accessibility/room/audioPage.dart';
import 'package:flutter_smartclass/page/accessibility/room/mainAc.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleList extends StatelessWidget {
  String title;
  final VoidCallback onTap;
  IconData icon;
  Color color;
  Color iconColor;
  bool isSelected;
  CircleList({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.color = secondary,
    this.iconColor = primary,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5.9,
        right: 5.9,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height / 11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? primary : secondary,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 34,
                  color: isSelected ? highlight : primary,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class CardDevice extends StatelessWidget {
  IconData icon;
  String status;
  String nameDevice;
  VoidCallback onTap;
  Widget leadingButton;
  Color iconColor;
  Color statsColor;
  CardDevice(
      {Key? key,
      required this.icon,
      required this.status,
      required this.nameDevice,
      required this.onTap,
      required this.leadingButton,
      this.iconColor = secondary,
      this.statsColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 6,
                      decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Icon(
                        icon,
                        size: 30,
                      )),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status: $status',
                          style: GoogleFonts.inter(
                            color: statsColor,
                          ),
                        ),
                        Text(
                          nameDevice,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [leadingButton],
              )
            ],
          ),
        ),
      ),
    );
  }
}
