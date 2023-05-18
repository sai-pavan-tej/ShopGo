import 'package:firebase_database/firebase_database.dart';

class RModel{
  String _id;
  String _name;
  int _quantity;

  RModel(this._name,this._quantity);

  RModel.withID(this._id,this._name,this._quantity);

  String get id => this._id;
  String get name => this._name;
  int get quantity => this._quantity;

  set name(String name){
    this._name=name;
  }

  set quantity(int quantity){
    this._quantity=quantity;
  }
  

  RModel.fromSnapshot(DataSnapshot snapshot){
    this._id = snapshot.key;
    this._name=snapshot.value['name'];
    this._quantity=snapshot.value['quantity'];
  }

  Map<String,dynamic> toJson(){
    return{
      "name":_name,
      "quantity":_quantity,
    };
  } 

}