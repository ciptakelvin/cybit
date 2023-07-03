import 'package:cybit/Screen/credit.dart';
import 'package:cybit/Screen/generator.dart';
import 'package:cybit/Screen/home.dart';
import 'package:cybit/Screen/simple.dart';
import 'package:flutter/material.dart';

void main() {
  Color _colorPrime = HexColor("#525FE1");
  Color _colorSec = HexColor("#F86F03");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: _colorPrime, secondary: _colorSec),
    ),
    initialRoute: "/",
    routes: {
      "/": (context) => const Home(),
      "/credit": (context) => const Credit(),
      "/simple": (context) => Simple(),
      "/generator": (context) => Generator()
    },
  ));
}

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
