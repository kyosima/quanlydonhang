import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quanlydonhang/model/chi_tiet_don_hang.dart';
import 'package:quanlydonhang/model/don_hang.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:quanlydonhang/pages/info.dart';
import 'package:quanlydonhang/pages/login_page.dart';
import 'package:http/http.dart' as http;

class ThongTinDonHang extends StatefulWidget {
  final DonHang donhang;
  final UserModel user;
  const ThongTinDonHang({required this.donhang, required this.user});

  @override
  _ThongTinDonHangState createState() => _ThongTinDonHangState();
}

class _ThongTinDonHangState extends State<ThongTinDonHang> {
  Future<ChiTietDonHang?> _getChitietdonhang() async {
    final url = Uri.parse(
        "https://quantri.mevivu.com/admin/api/thongtindonhang.php?id=${widget.donhang.id}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final resuft = jsonDecode(utf8.decode(response.bodyBytes));

      return ChiTietDonHang(
          id: resuft['id'],
          name: resuft['name'],
          ngaypost: resuft['ngaypost'],
          nguoipost: resuft['nguoipost'],
          trangthai: resuft['trangthai'],
          deadline: resuft['deadline'],
          giatien: resuft['giatien'],
          trangthaihost: resuft['trangthaihost'],
          giahost: resuft['giahost'],
          ngaybatdauhost: resuft['ngaybatdau'],
          tenmien: resuft['tenmien'],
          trangthaitenmien: resuft['trangthai'],
          giatenmien: resuft['giatenmien'],
          ngaybatdautenmien: resuft['ngaybatdautenmien'],
          tiencoc: resuft['tiencoc'],
          danhgia: resuft['danhgia'],
          gopy: resuft['gopy'],
          kythuat: resuft['kythuat'],
          sale: resuft['sale']);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _getChitietdonhang();
    var fullname = widget.user.name.split(' ');
    String _fullName = fullname[fullname.length - 1];
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Thông tin đơn hàng ${widget.donhang.id}'),
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
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                    child: Text(
                  "123",
                  style: TextStyle(fontSize: 23),
                )),
              ],
            ),
          ),
        ));
  }
}
