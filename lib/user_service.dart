import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String baseUrl = 'http://localhost:4000';

  Future<Map<String, dynamic>> getUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('Token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/auths/profils'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load user profile: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updatedUserProfile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('Token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/auths/profils'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updatedUserProfile),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user profile: ${response.statusCode} ${response.body}');
    }
  }

  Future<String> uploadProfilePicture(File imageFile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('Token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final uri = Uri.parse('$baseUrl/auths/profils/upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('photo', imageFile.path))
      ..headers.addAll({
        'Authorization': 'Bearer $token',
      });

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData) as Map<String, dynamic>;
      return data['filePath'] as String;
    } else {
      throw Exception('Failed to upload file: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
