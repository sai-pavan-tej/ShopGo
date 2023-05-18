import 'package:firebase_database/firebase_database.dart';

class Model{
  String _id;
  String _name;
  String _weight;
  int _price;
  String _expire;

  Model(this._name,this._weight,this._price,this._expire);

  Model.withID(this._id,this._name,this._weight,this._price,this._expire);

  String get id => this._id;
  String get name => this._name;
  String get weight => this._weight;
  int get price => this._price;
  String get expire => this._expire;

  set name(String name){
    this._name=name;
  }
  set weight(String weight){
    this._weight=weight;
  }
  set price(int price){
    this._price=price;
  }
  set expire(String expire){
    this._expire=expire;
  }

  Model.fromSnapshot(DataSnapshot snapshot){
    this._id = snapshot.key;
    this._name=snapshot.value['name'];
    this._weight=snapshot.value['weight'];
    this._price=snapshot.value['price'];
    this._expire=snapshot.value['expire'];
  }

  Map<String,dynamic> toJson(){
    return{
      "name":_name,
      "weight":_weight,
      "price":_price,
      "expire":_expire,
    };
  } 

}