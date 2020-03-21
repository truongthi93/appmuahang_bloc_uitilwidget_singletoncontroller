import 'dart:ffi';

import 'package:appmuahang/Singleton/SingletonPoint.dart';
import 'package:appmuahang/bloc/cart_bloc.dart';
import 'package:appmuahang/singleton/SingletonUser.dart';
import 'package:appmuahang/util/views/LoginDialog.dart';
import 'package:appmuahang/util/views/UserInfoWidget.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util/views/PointWidget.dart';
import '../model/product.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ Hàng"),
        actions: <Widget>[
          Row(
            children: <Widget>[
              new StreamBuilder<int>(
                  stream: SingletonPoint.instance.pointStream,
                  builder: (context, snap) =>
                      PointWidget()
              ),
              SizedBox(width: 20,),
            ],
          )
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.lightGreen,
            width: double.infinity,
            height: 40,
            child: StreamBuilder<UserStatus>(
                stream: SingletonUser.instance.userStream,
                builder: (context, snap) => UserInfoWidget()),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child:  _productListView(context),
          ),
        ],
      ),
    );
  }

  doLogin() async {
    var result = await LoginDialogWidget.instance.asyncInputDialog(context);
    var name = result[0];
    var pass = result[1];
    var status = SingletonUser.instance.checkUser(name, pass);
  }

  Widget _productListView(BuildContext context) {
    final CartBloc _bloc = BlocProvider.of<CartBloc>(context); // dat trong init
    return new StreamBuilder<List<Product>>(
      stream: _bloc.selectedProducts,
      initialData: _bloc.selectedProducts.value,
      builder: (context, listSnap) =>
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listSnap.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        trailing: GestureDetector(
                          onTap: () {
                            _deleteItem(listSnap.data[index], _bloc, index);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                        leading: Image(
                          image: AssetImage(_bloc.selectedProducts.value[index].image),
                          fit: BoxFit.fitWidth,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${_bloc.selectedProducts.value[index].name}'),
                              SizedBox(height: 5,),
                              Text('\u0024${_bloc.selectedProducts.value[index].price.toInt()}'),
                            ],
                          ),
                        )
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Tổng:", style: TextStyle(color: Colors.black, fontSize: 17),),
                    SizedBox(width: 20,),
                    Text("\u0024${_getCountPrice(listSnap.data)}", style: TextStyle(color: Colors.red, fontSize: 20),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  color: Colors.transparent,
                  width: 200,
                  height: 50,
                  child: FlatButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text("Mua hàng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                    onPressed: () {
                      if (SingletonUser.instance.getUser() == UserStatus.none) {
                        SingletonUser.instance.doLogin(context);
                      } else {
                        _deleteAllItemAndBack(_bloc, listSnap.data, context);
                      }
                    }),
                ),
              )
            ],
          ),
    );
  }

  int _getCountPrice(List<Product> listProduct) {
    double start = 0;
    listProduct.forEach((element) {
      start += element.price;
    });
    return start.toInt();
  }

  Future<void> _deleteItem(Product product, CartBloc blocProduct, int index) async {
    var action = await _asyncConfirmDialog(context, "Thông Báo", "Bạn có muống xoá ${product.name} giá \u0024${product.price.toInt()} ra khỏi giỏ hàng?");
    if (action == ConfirmAction.ACCEPT) {
      blocProduct.checkAddOrRemove(blocProduct.selectedProducts.value[index]);
      if (blocProduct.selectedProducts.value.isEmpty) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _deleteAllItemAndBack(CartBloc blocProduct,List<Product> list, BuildContext context) async {
    var action = await _showAlertBuy(_getCountPrice(list), context);
    if (action == ConfirmAction.ACCEPT) {
      blocProduct.deleteCart();
      Navigator.pop(context);
    }
  }


  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context, String title, String subTitle,) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(title),
          content: Text(subTitle),
          actions: <Widget>[
            FlatButton(
              child: const Text('Bỏ Qua'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('Đồng Ý'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  Future<ConfirmAction> _showAlertBuy(int money, BuildContext context) async {
    final CartBloc _bloc = BlocProvider.of<CartBloc>(context); // dat trong init
    final isCanbuy = SingletonPoint.instance.canbuy(money);
    return showDialog<ConfirmAction>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            'Mua hàng'.toUpperCase(),
            style: TextStyle(fontSize: 17.0, color: Colors.blue),
          ),
          content: Text(isCanbuy ? 'Mua thành công!' : 'Không đủ tiền!'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                if (isCanbuy) {
                  Navigator.of(context).pop(ConfirmAction.ACCEPT);
                  SingletonPoint.instance.buyProducts(money);
                } else {
                  Navigator.of(context).pop(ConfirmAction.CANCEL);
                }
              },
            ),
          ],
        );
      },
    );
  }
}