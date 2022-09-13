import 'package:flutter/material.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoList());
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
        onPressed: () => _displayDialog(context),
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

  // Function for deleting todos from the list
  void _deleteTodoItem(String todo) {
    setState(() {
      _todoList.remove(todo);
    });
  }

  // Function for deleting todos from the list
  void _editTodoItem(String todo, String newTodo) {
    int index = _todoList.indexOf(todo);
    setState(() {
      _todoList[index]=newTodo;
    });
  }

  // Function for rendering todo items
  Widget _buildTodoItem(String todo) {
    return Card(child:
      ListTile(
          title: Text(todo),
          trailing: Wrap(children: <Widget> [
            IconButton(
              icon: Icon(Icons.create),
              onPressed: () => _displayEditDialog(context, todo)
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _displayDeleteDialog(context, todo)
            )
          ])
        )
      );
  }

  // Display a dialog to edit the todo
  Future<dynamic> _displayEditDialog(BuildContext context, String todo) async {
    // change the app state to show a dialog
    _textFieldController.text=todo;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit todo'),
          // Field for editing todo
          content: TextField(
            controller: _textFieldController),
          // Components that have associated actions
          actions: <Widget>[
            // Confirm button
            TextButton(
              child: const Text('CONFIRM'),
              onPressed: () {
                Navigator.of(context).pop();
                _editTodoItem(todo, _textFieldController.text);
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

  // Display a dialog to delete the todo
  Future<dynamic> _displayDeleteDialog(BuildContext context, String todo) async {
    // change the app state to show a dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete todo'),
          // Components that have associated actions
          actions: <Widget>[
            // Confirm button
            TextButton(
              child: const Text('CONFIRM'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteTodoItem(todo);
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
              child: const Text('ADD'),
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