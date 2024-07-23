import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Models/todos.dart';
import 'package:todo_app/Services/todo_services.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs; // Make the list reactive
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchTodos();
    super.onInit();
  }

  void fetchTodos() async {
    try {
      var fetchedTodos = await apiService.getTodos();
      todos.value = fetchedTodos;
      debugPrint('Fetched Todos: $fetchedTodos');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // void fetchTodos() async {
  //   try {
  //     todos.value = [
  //       Todo(
  //         id: 1,
  //         title: 'Sample Todo',
  //         description: 'This is a sample description',
  //         completed: false,
  //       ),
  //       Todo(
  //         id: 1,
  //         title: 'Sample Todo',
  //         description: 'This is a sample description',
  //         completed: false,
  //       ),
  //     ];
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

  void addTodo(Todo todo) async {
    try {
      var newTodo = await apiService.createTodo(todo);
      todos.add(newTodo); // Add the new todo to the reactive list
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void updateTodo(int id, Todo todo) async {
    try {
      var updatedTodo = await apiService.updateTodo(id, todo);
      int index = todos.indexWhere((element) => element.id == id);
      if (index != -1) {
        todos[index] = updatedTodo;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void toggleTodoCompletion(int id) async {
    int index = todos.indexWhere((element) => element.id == id);
    if (index != -1) {
      var todo = todos[index];
      var updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        completed: !todo.completed,
      );
      updateTodo(id, updatedTodo);
    }
  }

  void deleteTodo(int id) async {
    try {
      await apiService.deleteTodo(id);
      todos.removeWhere((element) => element.id == id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
