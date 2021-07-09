import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quanlydonhang/model/don_hang.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:quanlydonhang/pages/info.dart';
import 'package:http/http.dart' as http;
import 'package:quanlydonhang/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _getDonHang();
    super.initState();
  }

  List<DonHang> donhang = [];
  Future<bool> _getDonHang() async {
    final url = Uri.parse(
        "https://quantri.mevivu.com/admin/api/danhsachdonhang.php?khachhangid=${widget.user.id}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final resuft = donHangFromJson(utf8.decode(response.bodyBytes));
      setState(() {
        donhang = resuft.values.toList();
      });

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var fullname = widget.user.name.split(' ');
    String _fullName = fullname[fullname.length - 1];
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Danh sách đơn hàng'),
        ),
        endDrawer: Drawer(
          elevation: 16.0,
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("${widget.user.name}"),
                accountEmail: Text("${widget.user.sdt}"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(_fullName),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Info(user: widget.user)));
                },
                title: new Text("Thông tin cá nhân"),
                leading: new Icon(Icons.person),
              ),
              Divider(
                height: 0.1,
              ),
              ListTile(
                title: new Text("Đăng xuất"),
                leading: new Icon(Icons.logout),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: donhang.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
              child: Card(
                child: InkWell(
                  onTap: () {
                    print('donhang details');
                  },
                  child: ListTile(
                    title: Text(donhang[index].name),
                    subtitle: Text(donhang[index].date),
                    trailing: Text('${donhang[index].status}'),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
