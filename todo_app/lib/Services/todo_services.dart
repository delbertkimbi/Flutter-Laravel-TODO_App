import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/Models/todos.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Todo>> getTodos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/todos'));
      if (response.statusCode == 200) {
        debugPrint('Raw Response: ${response.body}'); // Print raw response
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Todo> todos =
            jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
        debugPrint('Parsed Todos: $todos');
        return todos;
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      debugPrint('Error fetching todos: $e');
      rethrow;
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse("$baseUrl/todos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<Todo> updateTodo(int id, Todo todo) async {
    final response = await http.put(
      Uri.parse("$baseUrl/todos/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/todos/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
