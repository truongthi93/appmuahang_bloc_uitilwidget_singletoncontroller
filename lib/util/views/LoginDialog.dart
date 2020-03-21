import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginDialogWidget {
  static final LoginDialogWidget instance = LoginDialogWidget();
  LoginDialogWidget() {}
  Future<List<String>> asyncInputDialog(BuildContext context) async {
    String userName = '';
    String password = '';
    return showDialog<List<String>>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter your information'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: Column(
                    children: <Widget>[
                      new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Username', hintText: 'type username...'),
                        onChanged: (value) {
                          userName = value;
                        },
                      ),
                      new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Password', hintText: 'type password...'),
                        onChanged: (value) {
                          password = value;
                        },
                      )
                    ],
                  )
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop([userName, password]);
              },
            ),
          ],
        );
      },
    );
  }
}