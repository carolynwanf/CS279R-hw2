import 'package:flutter/material.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  // App layout
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-do List'),
        ),
      )
      
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // Save list of todos
  final List<String> _todoList = <String>[];
  // Input field for entering todos
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // app layout
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do List'),
      ),
    );
  }
}