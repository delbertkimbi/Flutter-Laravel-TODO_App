import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/View/task_description.dart';

class CustomTodo extends StatefulWidget {
  const CustomTodo({
    super.key,
    required this.deleteFunction,
    required this.onChanged,
    required this.name,
    required this.descript,
    required this.completed,
    required this.updateFunction,
  });

  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? updateFunction;
  final void Function(bool?)? onChanged;
  final String name;
  final String? descript;
  final bool completed;

  @override
  State<CustomTodo> createState() => _CustomTodoState();
}

class _CustomTodoState extends State<CustomTodo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetailsPage(
              name: widget.name,
              description: widget.descript ?? '',
              completed: widget.completed,
            ),
          ),
        );
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.updateFunction,
              backgroundColor: Colors.blue,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: widget.deleteFunction,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.withOpacity(0.2),
          ),
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: widget.completed,
                onChanged: widget.onChanged,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        decoration: widget.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    Text(
                      widget.descript!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        decoration: widget.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
