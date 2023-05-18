import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'model.dart';
import 'Rmodel.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _name = '';
  int _quantity;

  saveItem(BuildContext context) async {
    if (_name.isNotEmpty && _quantity!=0) {
      RModel model = RModel(this._name,this._quantity);

      await _databaseReference.child("Remainder").push().set(model.toJson());

      navigateToLastScreen(context);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Field Required !!! "),
              content: Text("All Fields are required !!! "),
              actions: <Widget>[
                FlatButton(
                    child: Text("CLOSE"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }
  }

  navigateToLastScreen(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text(
            "Add Item",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:20.0),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _name=value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top:20.0),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _quantity=int.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top:20.0),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                  onPressed: (){
                    saveItem(context);
                  },
                  color: Colors.blueAccent,
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
