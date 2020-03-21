import 'package:appmuahang/bloc/cart_bloc.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:appmuahang/Screen/Shop.dart';

void main() => runApp(
  // Create and provide the bloc.
  BlocProvider<CartBloc>(
    creator: (_context, _bag) => CartBloc(),
    child: MyApp(),
  ),
);


final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[routeObserver],
      home: HomePage(),
    );
  }
}