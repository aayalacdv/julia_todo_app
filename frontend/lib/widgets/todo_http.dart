import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:julia_app/models/todoService.dart';
import 'package:julia_app/models/todo_model.dart';

class Todo extends StatefulWidget {
  Todo({Key? key, required this.todo, required this.refreshUi})
      : super(key: key);

  TodoModel todo;
  bool isEditing = false;
  VoidCallback refreshUi;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TextEditingController controller =
      TextEditingController(text: 'Enter a new todo');

  String? get errorText {
    final text = controller.value.text;
    if (text.isEmpty) {
      return 'Text is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TodoService service = TodoService();

    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Checkbox(
            value: widget.todo.isDone,
            onChanged: (state) async {
              setState(() {
                widget.todo.isDone = state!;
              });
              await service.updateTodo(widget.todo);
            }),
        (widget.isEditing
            ? Container(
                width: size.width * .5,
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) async {
                    if (controller.value.text.isNotEmpty) {
                      setState(() {
                        widget.isEditing = !widget.isEditing;
                        widget.todo.title = value;
                      });
                      await service.updateTodo(widget.todo);
                    }
                  },
                  decoration: InputDecoration(
                      hintText: widget.todo.title,
                      errorText: errorText,
                      label: const Text('Editing Todo')),
                ),
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    widget.isEditing = !widget.isEditing;
                  });
                },
                child: Text(widget.todo.title))),
        IconButton(
            onPressed: () async {
              await service.deleteTodo(widget.todo.id!);
              widget.refreshUi();
            },
            icon: const Icon(Icons.delete))
      ]),
    );
  }
}
