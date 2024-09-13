import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/main.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auths/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map <String, dynamic> ;
      final token = data["access_token"];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Token, token!);
      // Assume successful login if status code is 200
      return true;
    } else {
      // Handle errors here
      return false;
    }
  }
}
