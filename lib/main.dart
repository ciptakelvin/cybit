import 'package:cybit/Screen/credit.dart';
import 'package:cybit/Screen/generator.dart';
import 'package:cybit/Screen/home.dart';
import 'package:cybit/Screen/simple.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/":(context) => Home(),
      "/credit":(context) => Credit(),
      "/simple":(context) => Simple(),
      "/generator":(context) => Generator()
    },
  ));
}