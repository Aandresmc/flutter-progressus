import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:login_progressus/models/userModel.dart';

class UserProvider {
  final String _url = 'http://192.168.1.52:8001/api';
  
  Future<dynamic> register(user) async {
    final url = '$_url/register';
    final resp = await http.post(url, body: user);
    return json.decode(resp.body);
  }

  Future<dynamic> login(user) async {
    final url = '$_url/login';
    final resp = await http.post(url, body: user);
    return json.decode(resp.body);
  }

  Future<List<UserModel>> users(String token) async {
    final url = '$_url/users';
    final resp = await http.post(
      url,
      headers: {
        'Authorization': "Bearer " + token,
        'Content-Type': 'aplication/json',
        'Accept': 'application/json'
      },
    );

    final decodedData = (json.decode(resp.body)['success']).toList();
    final List<UserModel> Users = new List();

    if (decodedData == null || decodedData.length == 0) return [];


    for (var user in decodedData) {
      final prodTemp = UserModel.fromJson(user);
      Users.add(prodTemp);
    }

    return Users;
  }
}
