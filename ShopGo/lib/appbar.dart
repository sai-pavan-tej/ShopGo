import 'package:flutter/material.dart';

class GradAppBar extends StatelessWidget {

  final double size= 66.0;

  @override
  Widget build(BuildContext context) {
    final double statusBarSize=MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top:statusBarSize),
      height: statusBarSize+size,
      child: Center(
        child: Text("shopgo",
        style: TextStyle(fontWeight: FontWeight.w600,fontSize: 36.0,color: Colors.white),),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3366FF),
            const Color(0xFF00CCFF),
          ],
          begin: FractionalOffset(0.0,0.0),
          end: FractionalOffset(1.0,0.0),
          //stops: [0.0,1.0],
          tileMode: TileMode.clamp,
        )
      ),
    );
  }
}