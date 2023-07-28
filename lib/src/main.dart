import 'package:flutter/material.dart';
import 'package:whats_next/src/features/list/presentation/todo_screen/ToDoList.dart';

void main() {
  runApp(const WhatsNextApp());
}

class WhatsNextApp extends StatelessWidget {
  const WhatsNextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whats Next',
      home: TodoList(),
    );
  }
}
