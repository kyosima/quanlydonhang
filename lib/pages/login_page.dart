import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quanlydonhang/api/api_service.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:quanlydonhang/pages/home_page.dart';
import 'package:quanlydonhang/services/service_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ILogin _loginService = LoginService();
  bool onloading = false;
  bool hidePassword = true;
  bool _validateUsername = false;
  bool _validatePassword = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  HexColor("#140f86"),
                  Colors.blue,
                ],
              )),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "Đăng Nhập",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  hintText: 'Tên đăng nhập',
                                  errorText: _validateUsername
                                      ? 'Tên đăng nhập không được để trống'
                                      : null,
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _passwordController,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                errorText: _validatePassword
                                    ? 'Mật khẩu không được để trống'
                                    : null,
                                hintText: 'Mật khẩu',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  color: Colors.blue
                                      .withOpacity(hidePassword ? 0.3 : 1),
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                child: onloading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text('Đăng nhập'),
                                onPressed: _submit,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Future<void> _submit() async {
    onloading = true;
    setState(() {
      _usernameController.text.isEmpty
          ? _validateUsername = true
          : _validateUsername = false;
      _passwordController.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
    });
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      UserModel? user = await _loginService.login(
          _usernameController.text, _passwordController.text);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Đăng nhập thành công'),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomePage(user: user),
          ),
        );
      } else if (user == null) {
        if (!Platform.isIOS) {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text("Lỗi đăng nhập"),
                    content:
                        new Text("Tên đăng nhập hoặc mật khẩu không đúng!"),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Đóng!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            onloading = false;
                          });
                        },
                      )
                    ],
                  ));
        } else {
          showDialog(
              context: context,
              builder: (_) => new CupertinoAlertDialog(
                    title: new Text("Lỗi đăng nhập"),
                    content:
                        new Text("Tên đăng nhập hoặc mật khẩu không đúng!"),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Đóng!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            onloading = false;
                          });
                        },
                      )
                    ],
                  ));
        }

        return null;
      }
    } else {
      print('NOT OK');
    }
  }
}
