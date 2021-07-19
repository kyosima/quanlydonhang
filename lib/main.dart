import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:quanlydonhang/pages/home_page.dart';

import 'package:quanlydonhang/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences storage = await SharedPreferences.getInstance();
  var name = storage.getString('NAME');
  var status = storage.getInt('STATUS');
  var id = storage.getInt('ID');
  var sdt = storage.getInt('SDT');

  runApp(MaterialApp(
    title: "Mevivu ID",
    theme: ThemeData(
      primaryColor: HexColor('#1967d2'),
    ),
    home: name == null
        ? LoginPage()
        : HomePage(
            user: UserModel(name: name, status: status, id: id, sdt: sdt)),
  ));
}
