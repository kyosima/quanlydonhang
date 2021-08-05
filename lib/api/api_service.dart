import 'dart:convert';

import 'package:quanlydonhang/model/login_model.dart';
import 'package:http/http.dart' as http;

abstract class ILogin {
  Future<UserModel?> login(String username, String password) async {
    final api = Uri.parse('https://quantri.mevivu.com/admin/api/dangnhap.php');
    final data = {"username": username, "password": password};
    http.Response response;
    response = await http.post(api, body: data);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 1) {
        final body = json.decode(response.body);
        print(body);
        return UserModel(
            name: body['name'],
            status: body['status'],
            id: body['id'],
            email: body['email'],
            address: body['address'],
            sdt: body['sdt']);
      }
    } else {
      return null;
    }
  }
}
