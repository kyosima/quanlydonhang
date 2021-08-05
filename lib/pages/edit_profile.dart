import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({this.user});
  final UserModel? user;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController(text: "${widget.user!.name}");
    final _emailController = TextEditingController(text: widget.user!.email);
    final _addressController =
        TextEditingController(text: widget.user!.address);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa thông tin cá nhân'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Họ và tên',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: '(+84) ${widget.user!.sdt}',
                enabled: false,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.phone,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.email,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.location_on,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    var client = http.Client();
                    try {
                      var uriResponse = await client.post(
                          Uri.parse(
                              'https://quantri.mevivu.com/admin/api/khachhangedit.php'),
                          body: jsonEncode({
                            'id': widget.user!.id,
                            'sdt': widget.user!.sdt,
                            'name': 'Bùi Thế Vũ',
                            'email': 'hello@gmail.com',
                            'diachi': '998/42/15 Quang Trung, Gò vấp',
                          }));
                      print('ok');
                      print('Response status: ${uriResponse.statusCode}');
                    } finally {
                      client.close();
                    }
                  },
                  icon: Icon(Icons.check_circle_outline),
                  label: Text('Cập nhật thông tin'))
            ],
          ),
        ),
      ),
    );
  }
}
