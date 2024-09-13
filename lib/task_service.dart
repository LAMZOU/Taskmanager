import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/task.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final response = await http.post(
      Uri.parse('$baseUrl/task'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
        'priority': priority,
        'color': color,
        'dueDate': dueDate.toIso8601String(),
      }),
    );

    return response.statusCode == 201;
  }

  Future<List<Task>> fetchTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final response = await http.get(
      Uri.parse('$baseUrl/task'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final tasks = Task.fromJsonList(data);
      return tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<bool> updateTask({
    required int id,
    required String title,
    required String content,
    required String priority,
    required String color,
    required DateTime dueDate,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final response = await http.put(
      Uri.parse('$baseUrl/task/{id}'), // Convert id to String here
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
        'priority': priority,
        'color': color,
        'dueDate': dueDate.toIso8601String(),
      }),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteTask(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final response = await http.delete(
      Uri.parse('$baseUrl/task/$id'), // Convert id to String here
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    return response.statusCode == 200;
  }
}
