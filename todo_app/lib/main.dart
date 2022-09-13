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
    // App layout
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do List'),
      ),
      body: ListView(children: _getItems()),
      // Button to add todos
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog,
        tooltip: 'Add Todo',
        child: Icon(Icons.add)),
    );
  }

  // Function for adding todos to the list
  void _addTodoItem(String todo) {
    // Call of set state initiates a re-render
    setState(() {
      _todoList.add(todo);
    });
    _textFieldController.clear();
  }

  // Function for rendering todo items
  Widget _buildTodoItem(String todo) {
    return ListTile(title: Text(todo));
  }

  // Display a dialog for the user to enter items
  Future<dynamic> _displayDialog(BuildContext context) async {
    // change the app state to show a dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo to your list'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Enter todo here')),
          // Components that have associated actions
          actions: <Widget>[
            // Add button
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              }
            ),
            // Cancel button
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]
        );
      }
    );
  }

  // Function that creates a list of tiles with the existing stored todos
  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String todo in _todoList) {
      _todoWidgets.add(_buildTodoItem(todo));
    }

    return _todoWidgets;
  }


}