import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final String baseUrl = 'http://localhost:4000'; 

  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/auths/profils'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
