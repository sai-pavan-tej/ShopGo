import 'package:flutter/material.dart';
import 'package:shopgoooo/AddPage.dart';
import 'package:shopgoooo/NavPage.dart';
import 'HomePage.dart';
import 'dart:async';
import 'SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopGO',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
