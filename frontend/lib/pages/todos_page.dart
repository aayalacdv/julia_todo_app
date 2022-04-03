import 'package:flutter/material.dart';
import 'package:julia_app/widgets/todo.dart';
import 'package:julia_app/widgets/todo_list.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$title'),
        ),
        body: const TodoList());
  }
}
