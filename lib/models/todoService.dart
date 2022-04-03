import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:julia_app/models/todo_model.dart';

class TodoService {
  var baseUrl = 'http://10.0.2.2:8080/api/';

  Future<TodoModel> getTodoById(String id) async {
    var res = await http.get(Uri.parse(baseUrl + 'todos/' + id));
    var decoded = jsonDecode(res.body);
    return TodoModel.fromJson(decoded);
  }

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

  Future<bool> deleteTodo(String id) async {
    var res = await http.delete(Uri.parse(baseUrl + 'todos/$id'));
    int statusCode = res.statusCode;
    if (statusCode == 200) return true;
    return false;
  }

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
