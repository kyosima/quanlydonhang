import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quanlydonhang/model/don_hang.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:quanlydonhang/pages/info.dart';
import 'package:http/http.dart' as http;
import 'package:quanlydonhang/pages/login_page.dart';
import 'package:quanlydonhang/pages/thongtin_donhang.dart';

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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              HexColor("#113fa7"),
              Colors.blue,
            ],
          )),
          child: ListView.builder(
            itemCount: donhang.length,
            itemBuilder: (context, index) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 3, bottom: 2),
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ThongTinDonHang(
                                      donhang: donhang[index],
                                      user: widget.user,
                                    )));
                      },
                      child: ListTile(
                        hoverColor: Colors.red,
                        isThreeLine: true,
                        leading: Image.asset(
                          'assets/images/mevivudonhang.png',
                          height: 45,
                        ),
                        title: Text(
                          '${donhang[index].name}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày khởi tạo : ${donhang[index].date}'),
                            Stack(
                              children: [
                                Container(
                                  color: Colors.red,
                                ),
                                donhang[index].status == 0
                                    ? Text(
                                        "Đang xử lý",
                                        style: TextStyle(
                                          color: Colors.orange,
                                        ),
                                      )
                                    : donhang[index].status == 1
                                        ? Text(
                                            "Đã kết thúc dự án",
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          )
                                        : donhang[index].status == 5
                                            ? Text(
                                                "Đã kết thúc dự án",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              )
                                            : donhang[index].status == 4
                                                ? Text("Đơn nợ xấu")
                                                : Text(""),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
