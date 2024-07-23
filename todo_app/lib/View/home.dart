import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Controllers/todo_controller.dart';
import 'package:todo_app/Models/todos.dart';
import 'package:todo_app/View/widgets/custom_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController descriptcontroller = TextEditingController();
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: EdgeInsets.zero,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Add Todo info',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: namecontroller,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Todo title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptcontroller,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Todo Description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      todoController.addTodo(Todo(
                        id: 0,
                        title: namecontroller.text,
                        description: descriptcontroller.text,
                        completed: false,
                      ));
                      Navigator.pop(context);
                      Get.snackbar('Added', 'Task added successfully');
                      namecontroller.clear();
                      descriptcontroller.clear();
                    },
                    child: const Text('  Add  '),
                  ),
                ],
              );
            },
          );
        },
        label: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.black,
              size: 25,
            ),
            Text(
              'Add Todo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'My Todos',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                SizedBox(width: 12),
                Icon(
                  Icons.delete,
                  color: Colors.blue,
                  size: 20,
                ),
                Text(
                  '  Slide left to edit or delete',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoController.todos.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTodo(
                          name: todoController.todos[index].title.trim(),
                          descript:
                              todoController.todos[index].description.trim(),
                          completed: todoController.todos[index].completed,
                          deleteFunction: (context) {
                            deleteTodo(index);
                          },
                          onChanged: (value) {
                            todoController.toggleTodoCompletion(
                                todoController.todos[index].id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTodo(int index) {
    todoController.deleteTodo(todoController.todos[index].id);
  }
}
