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
    print(response);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print(body);
      if (body['status'] == 1) {
        SharedPreferences storage = await SharedPreferences.getInstance();
        final body = json.decode(response.body);
        await storage.setString('NAME', body['name']);
        await storage.setInt('STATUS', body['status']);
        await storage.setInt('ID', body['id']);
        await storage.setInt('SDT', body['sdt']);
        await storage.setString('EMAIL', body['email']);
        await storage.setString('ADDRESS', body['address']);
        return UserModel(
          name: body['name'],
          status: body['status'],
          id: body['id'],
          sdt: body['sdt'],
          email: body['email'],
          address: body['address'],
        );
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final name = storage.getString('NAME');
    final status = storage.getInt('STATUS');
    final id = storage.getInt('ID');
    final sdt = storage.getInt('SDT');
    if (name != null && status != null && id != null && sdt != null) {
      await storage.remove('NAME');
      await storage.remove('STATUS');
      await storage.remove('ID');
      await storage.remove('SDT');
      return true;
    } else {
      return false;
    }
  }
}
