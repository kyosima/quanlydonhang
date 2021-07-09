import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quanlydonhang/api/api_service.dart';
import 'package:quanlydonhang/model/login_model.dart';

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
}
