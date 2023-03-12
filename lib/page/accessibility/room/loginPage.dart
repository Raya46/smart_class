// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/constant.dart';
import 'package:flutter_smartclass/mainNavigation.dart';
import 'package:flutter_smartclass/model/api_response.dart';
import 'package:flutter_smartclass/model/user.dart';
import 'package:flutter_smartclass/page/home/mainHome.dart';
import 'package:flutter_smartclass/services/user_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;
  TextEditingController passCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  bool loading = false;

  void loginUser() async {
    ApiResponse response = await login(emailCon.text, passCon.text);
    print(emailCon.text);
    if (response.error == null) {
      saveAndDirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void saveAndDirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('id', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NavigationPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              Container(
                height: height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 125, 251, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          SizedBox(
                            height: 17,
                          ),
                          Icon(
                            Icons.charging_station_outlined,
                            size: 40,
                            color: Color.fromARGB(255, 18, 50, 97),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(0.0, -90.0, 0.0),
                    padding: EdgeInsets.all(15.0),
                    height: 450,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: 30,
                              bottom: 10,
                            ),
                            child: Text(
                              'S P K L U',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Sign in your account.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                      top: 25,
                                      right: 30,
                                      left: 30,
                                      bottom: 10,
                                    ),
                                    child: TextFormField(
                                      controller: emailCon,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) =>
                                          value!.isEmpty ? 'invalid' : null,
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                      top: 8,
                                      right: 30,
                                      left: 30,
                                      bottom: 10,
                                    ),
                                    child: TextFormField(
                                      controller: passCon,
                                      // keyboardType: TextInputType.emailAddress,
                                      validator: (value) =>
                                          value!.isEmpty ? 'invalid' : null,
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      right: 30,
                                      left: 30,
                                      bottom: 10,
                                    ),
                                    child: ElevatedButton(onPressed: (){
                                      // print(emailCon.text);
                                      // print(passCon.text);
                                      // _submit();
                                      loginUser();
                                      // login(emailCon.text, passCon.text);
                                      // Navigator.push(
                                      // context,
                                      // MaterialPageRoute(builder: (context) => HomePage()),
                                      // );
                                    },child: Text('tre'),)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
