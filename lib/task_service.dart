import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskService {
  final String baseUrl = 'http://localhost:4000';

  TaskService(String s);

  Future<bool> addTask({
    required String title,
    required String content,
    required String priority,
    required String color,
    required DateTime dueDate,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'), // URL de l'endpoint pour ajouter une tâche
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
        'priority': priority,
        'color': color,
        'dueDate': dueDate.toIso8601String(), // Convertir DateTime en chaîne ISO 8601
      }),
    );

    // Vérifiez que le code de statut pour une tâche créée est 201
    return response.statusCode == 201;
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
