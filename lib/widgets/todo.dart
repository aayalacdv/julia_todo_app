import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:julia_app/models/todo_model.dart';

class Todo extends StatefulWidget {
  Todo(
      {Key? key,
      required this.title,
      required this.deleteTodo,
      required this.modifyTodo,
      this.isDone = false})
      : super(key: key);

  String title;
  bool isDone;
  VoidCallback deleteTodo;
  Function(String, bool) modifyTodo;
  bool isEditing = false;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TextEditingController controller =
      TextEditingController(text: 'Enter a new todo');

  String? get errorText {
    final text = controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Text is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Checkbox(
            value: widget.isDone,
            onChanged: (state) => {
                  setState(() {
                    widget.isDone = state!;
                    widget.modifyTodo(widget.title, widget.isDone);
                  })
                }),
        (widget.isEditing
            ? Container(
                width: size.width * .5,
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    if (controller.value.text.isNotEmpty) {
                      setState(() {
                        widget.isEditing = !widget.isEditing;
                        widget.title = value;
                        widget.modifyTodo(widget.title, widget.isDone);
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintText: widget.title,
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
                child: Text(widget.title))),
        IconButton(
            onPressed: () => widget.deleteTodo(),
            icon: const Icon(Icons.delete))
      ]),
    );
  }
}
