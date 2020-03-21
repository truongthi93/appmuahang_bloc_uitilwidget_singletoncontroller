import 'package:appmuahang/model/MoneyText.dart';
import 'package:appmuahang/util/views/LoginDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum UserStatus {
  none,
  not_veryfied,
  verify
}

//class User {
//  String name;
//  UserStatus status;
//
//  User getDefaultUser() {
//    var user = User();
//    user.status = UserStatus.none;
//    user.name = "";
//  }
//
//}

class SingletonUser {
  static final SingletonUser instance = SingletonUser();
  SingletonUser() {}
  UserStatus _status;

  final _userController = BehaviorSubject<UserStatus>.seeded(UserStatus.none);
  ValueStream<UserStatus> get userStream => _userController.stream;

  UserStatus getUser() => _status;

  void logout() {
    this._status =  UserStatus.none;
    _userController.add(UserStatus.none);
  }

  void verifyUser() {
    this._status =  UserStatus.verify;
    _userController.add(UserStatus.verify);
  }

  UserStatus checkUser(String name, String pass) {
    if (name == "admin1" && pass == "111") {
      this._status = UserStatus.verify;
      _userController.add(UserStatus.verify);
    } else if (name == "admin2" && pass == "222") {
      this._status = UserStatus.not_veryfied;
      _userController.add(UserStatus.not_veryfied);
    } else {
      this._status =  UserStatus.none;
      _userController.add(UserStatus.none);
    }
  }

  // WRAP FUNCTIONS
  doLogin(BuildContext context) async {
    var result = await LoginDialogWidget.instance.asyncInputDialog(context);
    var name = result[0];
    var pass = result[1];
    SingletonUser.instance.checkUser(name, pass);
  }

  doLogout() {
    SingletonUser.instance.logout();
  }

  doVerify() {
    SingletonUser.instance.verifyUser();
  }
}