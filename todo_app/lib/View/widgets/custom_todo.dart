import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class CustomTodo extends StatefulWidget {
  CustomTodo({
    super.key,
    required this.deleteFunction,
    required this.onChanged,
    required this.name,
    required this.descript,
  });
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;
  Function(bool)? onChanged;
  final String name;
  final String? descript;

  @override
  State<CustomTodo> createState() => _CustomTodoState();
}

class _CustomTodoState extends State<CustomTodo> {
  bool isChecked = false; // Initial state of the checkbox
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: widget.deleteFunction,
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
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.descript!.length < 15
                        ? widget.descript!
                        : "${widget.descript!.substring(0, 15)}...",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
