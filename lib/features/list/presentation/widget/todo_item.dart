import 'package:flutter/material.dart';

class Todo {
  Todo({required this.name, required this.checked, required this.dueDate});
  final String name;
  bool checked;
  final DateTime dueDate;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    required this.dueDate,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;
  final DateTime dueDate;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      tileColor: Colors.white,
      onTap: () {
        onTodoChanged(todo);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
    );
  }
}
