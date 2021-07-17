import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
            case ConnectionState.none:
              return LoginPage();
            default:
              if (snapshot != null) {
                print(snapshot.data);
                return LoginPage();
              } else {
                return LoginPage();
              }
          }
        },
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginPage(),
      },
    );
  }
}
