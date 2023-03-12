import 'package:flutter/material.dart';

const baseApi = 'http://192.168.105.56:8000/api';
const loginApi = 'http://192.168.105.56:8000/api/login';
const registerApi = '$baseApi/register';
const logoutApi = '$baseApi/logout';
const userApi = '$baseApi/user';

const serverError = 'server eror';
const unauthorized = 'unauthorized';
const somethingWrong = 'something Wrong';

TextButton LoadTextButton(String lable, Function onpressed){
  return TextButton(onPressed: () => onpressed, child: Text(lable));
}
