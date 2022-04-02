import 'package:julia_app/models/todo_model.dart';
import 'package:julia_app/widgets/todo.dart';
import 'package:rxdart/rxdart.dart';

List<TodoModel> todos = [
  TodoModel(title: 'this is a todo'),
  TodoModel(title: 'this is another todo'),
  TodoModel(title: 'this is not a todo'),
];

//manejamos la lógica de la lista
class TodoListBloc {
  //creamos el observable o sea el vector que se tiene que escuchar
  //El beahviour subject solo emite el último valor de lo que se está escuchando
  late BehaviorSubject<List<TodoModel>> _todoList;

  TodoListBloc() {
    _todoList = BehaviorSubject.seeded(todos);
  }
  //creamos el pounto de entrada de los datos
  Sink<List<TodoModel>> get todoListSink => _todoList.sink;
  //creamos el steam para que el compoente pueda escuchar o sea el punto de salida
  Stream<List<TodoModel>> get todoList$ => _todoList.stream;

  //Manejamos las operaciones con la lista

  //cremaos el sink para poder acceder al contenido del componente
  List<TodoModel> get todosValue => _todoList.value;

  //añadir un valor al todo
  void addtodo(TodoModel todo) {
    todos = _todoList.value;
    todos.add(todo);
    todoListSink.add([...todos]);
  }

  //quitar un valor del todo
  void deleteTodo(TodoModel todo) {
    todos = _todoList.value;
    todos.removeWhere((element) => (element == todo));
    todoListSink.add([...todos]);
  }

  void modifyTodo(int index, String title, bool isDone) {
    var todos = _todoList.value;
    todos.map((todo) {
      if (todos.indexOf(todo) == index) {
        todos[index].title = title;
        todos[index].isDone = isDone;
      }
    }).toList();

    todoListSink.add([...todos]);
  }
}
