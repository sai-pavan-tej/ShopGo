import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "About",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Center(child: Text("Hail onion developers !!! "),),
    );
  }
}
