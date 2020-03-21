import 'package:appmuahang/singleton/SingletonUser.dart';
import 'package:flutter/material.dart';
import '../../Singleton/SingletonPoint.dart';
import 'LoginDialog.dart';

class UserInfoWidget extends StatefulWidget {
  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    switch (SingletonUser.instance.getUser()) {
      case UserStatus.not_veryfied:
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Unverify User',
                      style:
                          TextStyle(fontSize: 18, color: Colors.yellowAccent),
                    ),
                    Container(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        SingletonUser.instance.doLogout();
                      },
                      child: Text(
                        "Log out",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        SingletonUser.instance.doVerify();
                      },
                      child: Text(
                        "Verify Now",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            ]);
      case UserStatus.verify:
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Verified User',
                      style:
                          TextStyle(fontSize: 18, color: Colors.yellowAccent),
                    ),
                    Container(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        SingletonUser.instance.doLogout();
                      },
                      child: Text(
                        "Log out",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            ]);
      default:
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Guest User',
                      style:
                          TextStyle(fontSize: 18, color: Colors.yellowAccent),
                    ),
                    Container(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        SingletonUser.instance.doLogin(context);
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            ]);
    }
  }
}
