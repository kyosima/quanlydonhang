import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:quanlydonhang/pages/AutoLogin.dart';
import 'package:quanlydonhang/pages/home_page.dart';

import 'package:quanlydonhang/pages/login_page.dart';
import 'package:quanlydonhang/services/service_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: HexColor("#113fa7"),
      ),
      home: FutureBuilder(
        future: LoginService().getUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 3.0,
                ),
              );

            default:
              if (snapshot.hasData) {
                print(snapshot.data);
                return HomePage(
                    user: UserModel(
                        name: "Âu Thị Thanh Dân",
                        status: 1,
                        id: 5788,
                        sdt: 346678265));
              } else {
                return LoginPage();
              }
          }
        },
      ),
    );
  }
}
