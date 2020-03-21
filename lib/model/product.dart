import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Product {
  String name;
  String image;
  double price;

  Product(this.name, this.price, this.image);

//  Product(String name, double price, String image){
//    this.name = name;
//    this.image = image;
//    this.price = price;
//  }
}