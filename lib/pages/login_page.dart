import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool activeloggin = true;
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
                                child: onloading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "????ng Nh???p",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  hintText: 'T??n ????ng nh???p',
                                  errorText: _validateUsername
                                      ? 'T??n ????ng nh???p kh??ng ???????c ????? tr???ng'
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
                                    ? 'M???t kh???u kh??ng ???????c ????? tr???ng'
                                    : null,
                                hintText: 'M???t kh???u',
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
                                child: Text('????ng nh???p'),
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
        Fluttertoast.showToast(
            msg: "B???n ???? ????ng nh???p th??nh c??ng!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
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
                    title: new Text("L???i ????ng nh???p"),
                    content:
                        new Text("T??n ????ng nh???p ho???c m???t kh???u kh??ng ????ng!"),
                    actions: <Widget>[
                      TextButton(
                        child: Text('????ng!'),
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
                    title: new Text("L???i ????ng nh???p"),
                    content:
                        new Text("T??n ????ng nh???p ho???c m???t kh???u kh??ng ????ng!"),
                    actions: <Widget>[
                      TextButton(
                        child: Text('????ng!'),
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
      if (!Platform.isIOS) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('L???i ????ng nh???p'),
                  content: new Text(
                      "T??n ????ng nh???p ho???c m???t kh???u kh??ng ???????c ????? tr???ng!"),
                  actions: <Widget>[
                    TextButton(
                      child: Text('????ng!'),
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
            builder: (_) => CupertinoAlertDialog(
                  title: Text('L???i ????ng nh???p'),
                  content: new Text(
                      "T??n ????ng nh???p ho???c m???t kh???u kh??ng ???????c ????? tr???ng!"),
                  actions: <Widget>[
                    TextButton(
                      child: Text('????ng!'),
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
    }
  }
}
