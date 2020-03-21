import 'package:appmuahang/model/MoneyText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SingletonPoint {
  static final SingletonPoint instance = SingletonPoint();
  SingletonPoint() {}
  int _point = 0;

  final _pointController = BehaviorSubject<int>.seeded(0);
  ValueStream<int> get pointStream => _pointController.stream;

  int getPoint() => _point;
  setPoint(int point) {
    this._point = point;
    _pointController.add(getPoint());
  }

  buyProducts(int point) {
    this._point -= point;
    //pointValue.value = getPoint();
    _pointController.add(getPoint());
  }

  bool canbuy(int point) {
    return this._point >= point;
  }
}
