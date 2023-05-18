import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'ChatBot.dart';
import 'RemainderPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  var _selectedIndex;
  var _pageOptions = [
    HomePage(), 
    RemainderPage(),
    ChatBot()
  ];

  @override
  initState() {
    super.initState();

    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        height: 60,
        items: <Widget>[
          Icon(Icons.shopping_cart,color: Colors.white, size: 20),
          Icon(Icons.note,color: Colors.white, size: 20),
          Icon(Icons.chat,color: Colors.white, size: 20),
        ],
        onTap: (index) {
          setState(() {
            this._selectedIndex=index;
          });
        },
      ),
    );
  }
}
