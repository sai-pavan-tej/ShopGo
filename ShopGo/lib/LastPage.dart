import 'package:flutter/material.dart';

class LastPage extends StatefulWidget {
  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  AssetImage barcode = AssetImage("assets/images/Barcode.png");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text("Thank You",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image(
                      image: barcode,
                    ),),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 150.0),
              ),
              Text("Scan QR to continue...",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}