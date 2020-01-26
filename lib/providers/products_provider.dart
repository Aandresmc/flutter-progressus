import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_progressus/models/userModel.dart';

class UserProvider {
  final String _url = 'http://192.168.1.52:8001/api';

  Future<dynamic> register(UserModel user) async {
    final url = '$_url/register';

    final resp = await http.post(url, body: json.encode(user.toJson()));

    final decodedData = json.decode(resp.body);

    print(decodedData);
  }

  Future<dynamic> login(UserModel user) async {
    final url = '$_url/login';

    final resp = await http.post(url, body: json.encode(user.toJson()));

    final decodedData = json.decode(resp.body);

    print(decodedData);
  }

  Future<List<UserModel>> loadUser() async {
    final url = '$_url/users';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<UserModel> Users = new List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final prodTemp = UserModel.fromJson(value);
      Users.add(prodTemp);
    });

    return Users;
  }
}
