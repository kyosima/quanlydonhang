import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quanlydonhang/pages/login_page.dart';

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
      home: LoginPage(),
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginPage(),
      },
    );
  }
}
