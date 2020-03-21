import 'package:flutter/material.dart';
import '../../Singleton/SingletonPoint.dart';

class PointWidget extends StatefulWidget {
  @override
  _PointWidgetState createState() => _PointWidgetState();
}

class _PointWidgetState extends State<PointWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Text(
        '\$${SingletonPoint.instance.getPoint()}',
        style: TextStyle(
          color: Colors.yellowAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}