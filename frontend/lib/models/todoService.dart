import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:julia_app/models/todo_model.dart';

class TodoService {
  var baseUrl = 'http://10.0.2.2:8080/api/';

  //En dart las promesas se llaman Future<T> normalemtne T es dynamic pero podemos ponerle un tipo para trabajar mejor
  //los hay muchas cosas que se tienen que hacer de forma manual por que el framwork no puede parsear json automáticamnete por alguna razón
  //Por muchas cosas buenas que tengan como por ejemplo la construcción de la UI
  //la parte de implementar la lógica de la app deja bastante que desear

  //Get a todo by id
  Future<TodoModel> getTodoById(String id) async {
    var res = await http.get(Uri.parse(baseUrl + 'todos/' + id));
    var decoded = jsonDecode(res.body);
    return TodoModel.fromJson(decoded);
  }

  //Get all todos
  Future<List<TodoModel>?> getTodos() async {
    var res = await http.get(Uri.parse(baseUrl));
    var decoded = jsonDecode(res.body);
    List<TodoModel> todos = [];
    if (res.statusCode == 200) {
      decoded.forEach((todo) => todos.add(TodoModel.fromJson(todo)));
      return todos;
    }
    return null;
  }

  //create  a todo
  Future<TodoModel?> postTodo(TodoModel todo) async {
    var url = Uri.parse(baseUrl + 'todos');
    var res = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: json.encode(TodoModel.toJson(todo)));
    if (res.statusCode == 201) {
      TodoModel newTodo = TodoModel.fromJson(jsonDecode(res.body));
      return newTodo;
    }
    return null;
  }

  //delete a todo
  Future<bool> deleteTodo(String id) async {
    var res = await http.delete(Uri.parse(baseUrl + 'todos/$id'));
    int statusCode = res.statusCode;
    if (statusCode == 200) return true;
    return false;
  }

  //update todo
  Future<TodoModel?> updateTodo(TodoModel todo) async {
    String? id = todo.id;
    var res = await http.put(Uri.parse(baseUrl + 'todos/$id'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(TodoModel.toJson(todo)));

    if (res.statusCode == 200) {
      TodoModel newTodo = TodoModel.fromJson(jsonDecode(res.body));
      return newTodo;
    }

    return null;
  }
}
