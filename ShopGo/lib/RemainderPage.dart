import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'AddPage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class RemainderPage extends StatefulWidget {
  @override
  _RemainderPageState createState() => _RemainderPageState();
}

class _RemainderPageState extends State<RemainderPage> {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('Remainder');

  final headerTextStyle = TextStyle(fontFamily: 'Poppins').copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

  final regularTextStyle = TextStyle(fontFamily: 'Poppins').copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400);

  navigateToAddPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Keep Items",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: FirebaseAnimatedList(
          query: _databaseReference,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return GestureDetector(
                onTap: () {
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Container(
                        height: 63.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Container(
                          margin:
                              new EdgeInsets.fromLTRB(70.0, 13.0, 16.0, 16.0),
                          constraints: new BoxConstraints.expand(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(height: 4.0),
                              new Text(
                                "${snapshot.value['name']} \t\t\t\t\tX ${snapshot.value['quantity']}",
                                style: headerTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          navigateToAddPage();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}