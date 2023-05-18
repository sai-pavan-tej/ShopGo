import 'package:flutter/material.dart';
import 'ItemSummary.dart';
import 'package:firebase_database/firebase_database.dart';
import 'model.dart';

class ViewPage extends StatefulWidget {
  String _id;
  ViewPage(this._id);
  @override
  _ViewPageState createState() => _ViewPageState(_id);
}

class _ViewPageState extends State<ViewPage> {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('items');
  
  AssetImage backimage = AssetImage("assets/images/ShopGoLOGO.jpg");

  String id;
  _ViewPageState(this.id);
  Model _item;
  bool isLoading = true;

  getItem(id) async {
    _databaseReference.child(id).child('data').onValue.listen((event) {
      setState(() {
        _item = Model.fromSnapshot(event.snapshot);
        isLoading = false;
      });
    });
    print(_item.name);
  }

  @override
  void initState(){
    super.initState();
    this.getItem(id);
  }

  Container _getBackground() {
    return new Container(
      child: new Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTM88rWQJRuDr0t_tZZuzwj6_7lUZfSzm0L1c1SDa4o6KQXtQTP",
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 300.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00736AB7),Colors.blue],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }

  Widget _getContent() {
    return ListView(
      padding: EdgeInsets.fromLTRB(0.0, 230.0, 40.0, 32.0),
      children: <Widget>[
        ItemSummary(_item),
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("OVERVIEW",
                  style: TextStyle(fontFamily: 'Poppins').copyWith(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600)),
              Container(
                  margin: new EdgeInsets.symmetric(vertical: 8.0),
                  height: 2.0,
                  width: 18.0,
                  color: new Color(0xff00c6ff)),
              Text("It is just a soap",
                  style: TextStyle(fontFamily: 'Poppins').copyWith(
                      color: Colors.white,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: Colors.blue,
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }
}
