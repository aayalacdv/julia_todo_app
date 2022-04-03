import 'package:flutter/material.dart';
import 'package:julia_app/models/todo_model.dart';
import 'package:julia_app/models/todolist_bloc.dart';
import 'package:julia_app/widgets/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoListBloc todoListManager = TodoListBloc();
    TextEditingController textController =
        TextEditingController(text: 'Enter a todo');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StreamBuilder(
            stream: todoListManager.todoList$,
            builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
              return Column(
                children: [
                  if (snapshot.hasData)
                    ...snapshot.data!.map((todo) => Todo(
                        isDone: todo.isDone,
                        title: todo.title,
                        modifyTodo: (newTitle, newIsDone) {
                          int index = snapshot.data!.indexOf(todo);
                          todoListManager.modifyTodo(
                              index, newTitle, newIsDone);
                        },
                        deleteTodo: () {
                          todoListManager.deleteTodo(todo);
                        })),
                ],
              );
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              label: Text('Todo title'),
              hintText: 'Enter a todo',
              errorText: (textController.text.isEmpty) ? 'Text is empty' : null,
            ),
            onSubmitted: (value) {
              if (textController.text.isNotEmpty) {
                todoListManager.addtodo(TodoModel(title: textController.text));
                textController.text = '';
              }
            },
          ),
        )
      ],
    );
  }
}
