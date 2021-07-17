import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quanlydonhang/model/don_hang.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:quanlydonhang/pages/info.dart';
import 'package:quanlydonhang/pages/lichsu_thanhtoan.dart';
import 'package:quanlydonhang/pages/lienhe.dart';
import 'package:quanlydonhang/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:quanlydonhang/pages/yeucau_donhang.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ThongTinDonHang extends StatefulWidget {
  final DonHang donhang;
  final UserModel user;
  const ThongTinDonHang({required this.donhang, required this.user});

  @override
  _ThongTinDonHangState createState() => _ThongTinDonHangState();
}

class _ThongTinDonHangState extends State<ThongTinDonHang> {
  String valDanhgia = "";

  final _gopy = TextEditingController();
  final List<Map<String, dynamic>> _items = [
    {
      'value': 2,
      'label': 'Rất hài lòng',
      'icon': Icon(Icons.sentiment_very_satisfied),
    },
    {
      'value': 1,
      'label': 'Hài lòng',
      'icon': Icon(Icons.sentiment_satisfied),
    },
    {
      'value': 0,
      'label': 'Tốt, ổn',
      'icon': Icon(Icons.sentiment_neutral),
    },
    {
      'value': -1,
      'label': 'Tệ',
      'icon': Icon(Icons.sentiment_dissatisfied),
    },
    {
      'value': -2,
      'label': 'Rất tệ',
      'icon': Icon(Icons.sentiment_very_dissatisfied),
    },
  ];

  Map<String, dynamic> chitietdonhang = {};

  Future _getChitietdonhang() async {
    final url = Uri.parse(
        "https://quantri.mevivu.com/admin/api/thongtindonhang.php?id=${widget.donhang.id}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final resuft = jsonDecode(utf8.decode(response.bodyBytes));

      chitietdonhang = resuft;
      return chitietdonhang;
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
        floatingActionButton: FloatingActionButton(
          onPressed: _launchURL,
          child: const Icon(Icons.chat),
          backgroundColor: Colors.lightGreen,
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
                title: new Text("Liên hệ Mevivu"),
                leading: new Icon(Icons.contact_support),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LienHe()));
                },
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
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                HexColor("#113fa7"),
                Colors.blue,
              ],
            )),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder(
                  future: _getChitietdonhang(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 80,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.9),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      chitietdonhang['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Ngày khởi tạo :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                                "${chitietdonhang['ngaypost']}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.saved_search,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Tình trạng : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['trangthai']}",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Tiền cọc : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['tiencoc']} vnđ",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Giá tiền : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['giatien']} vnđ",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.network_check,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Giá hosting : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['giahost']} vnđ",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.update,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Ngày khởi tạo hosting : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['ngaybatdauhost']}",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.domain,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Tên miền : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['tenmien']}",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.security,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Trạng thái tên miền : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['trangthaitenmien']}",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.price_change,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Giá tên miền : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['giatenmien']} vnđ",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Ngày khởi tạo tên miền : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${chitietdonhang['ngaybatdautenmien']}",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.emoji_people,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Nhân viên sale xử lý : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${chitietdonhang['sale']}",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.person_outline_sharp,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Kỹ thuật viên xử lý : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${chitietdonhang['kythuat']}",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Đánh giá : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: chitietdonhang['danhgia'] == 2
                                              ? Text("Rất hài lòng")
                                              : chitietdonhang['danhgia'] == 1
                                                  ? Text("Hài lòng")
                                                  : chitietdonhang['danhgia'] ==
                                                          0
                                                      ? Text("Tốt, Ổn")
                                                      : chitietdonhang[
                                                                  'danhgia'] ==
                                                              -1
                                                          ? Text("Tệ")
                                                          : chitietdonhang[
                                                                      'danhgia'] ==
                                                                  -2
                                                              ? Text("Rất tệ")
                                                              : Text(
                                                                  "Chưa đánh giá"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline_sharp,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Góp ý : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${chitietdonhang['gopy']}",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                          child: Text(
                                            'Yêu cầu đơn hàng',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => YeuCau(
                                                          id: chitietdonhang[
                                                              'id'],
                                                        )));
                                          },
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                          ),
                                          child: Text(
                                            'Lịch sử thanh toán',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        LichSuThanhToan(
                                                            id: chitietdonhang[
                                                                'id'])));
                                          },
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: ElevatedButton(
                                      child: Text(
                                        'Đánh giá, Góp ý',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: _danhgia,
                                    )),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )),
          ),
        ));
  }

  void _launchURL() async => await canLaunch("https://m.me/mevivu")
      ? await launch("https://m.me/mevivu")
      : throw 'Could not launch ${"https://m.me/mevivu"}';

  void _danhgia() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.white,
                height: 900,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Đánh giá và Góp ý',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown, // or can be dialog
                      initialValue: '${chitietdonhang['danhgia']}',
                      icon: Icon(Icons.star),
                      labelText: 'Đánh giá',
                      items: _items,
                      onChanged: (val) {
                        setModalState(() {
                          valDanhgia = val;
                          print(int.parse(valDanhgia));
                        });
                      },
                      onSaved: (val) {
                        setModalState(() {
                          valDanhgia = val!;
                          print(int.parse(valDanhgia));
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _gopy,
                      maxLines: 8,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: new BorderSide(
                              color: Colors.teal.withOpacity(0.2)),
                        ),
                        hintText: "Góp ý cho chúng tôi!",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        child: Text(
                          'Gửi đánh giá \& Góp ý',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          setState(() {
                            _submit();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Future _submit() async {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Cảm ơn bạn đã đánh giá, góp ý với chúng tôi!'),
      ),
    );
    final apiDanhgia =
        "https://quantri.mevivu.com/admin/api/luudanhgia.php?danhgia=${int.parse(valDanhgia)}&gopy=${_gopy.text.isEmpty ? chitietdonhang['gopy'] : _gopy.text}&id=${chitietdonhang['id']}";
    return http.get(Uri.parse(apiDanhgia));
  }
}
