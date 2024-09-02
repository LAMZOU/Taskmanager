import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:4000'; // Remplacez par votre URL API

  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auths/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
       
  "nom": lastName,
  "prenom": firstName,
  "email": email,
  "password": password,
  "username": username,
  "photo": ""

      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to register user');
    }
  }
} 