import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quanlydonhang/api/api_service.dart';
import 'package:quanlydonhang/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends ILogin {
  @override
  Future<UserModel?> login(String username, String password) async {
    final api = Uri.parse('https://quantri.mevivu.com/admin/api/dangnhap.php');
    final data = {"username": username, "password": password};
    http.Response response;
    response = await http.post(api, body: data);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 1) {
        SharedPreferences storage = await SharedPreferences.getInstance();
        final body = json.decode(response.body);
        await storage.setString('NAME', body['name']);
        await storage.setInt('STATUS', body['status']);
        await storage.setInt('ID', body['id']);
        await storage.setInt('SDT', body['sdt']);
        return UserModel(
            name: body['name'],
            status: body['status'],
            id: body['id'],
            sdt: body['sdt']);
      }
    } else {
      return null;
    }
  }

  Future<UserModel?> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final name = storage.getString('NAME');
    final status = storage.getInt('STATUS');
    final id = storage.getInt('ID');
    final sdt = storage.getInt('SDT');
    print(name);
    print(status);
    print(id);
    print(sdt);
    if (name != null && status != null && id != null && sdt != null) {
      return UserModel(name: name, status: status, id: id, sdt: sdt);
    } else {
      return null;
    }
  }
}
