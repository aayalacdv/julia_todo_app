class TodoModel {
  String? id;
  String title;
  bool isDone;

  TodoModel({required this.title, this.id, this.isDone = false});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        title: json['title']!, id: json['_id'], isDone: json['isDone']);
  }

  static Map<String, dynamic> toJson(TodoModel todo) {
    return {
      'isDone': todo.isDone,
      'title': todo.title,
      'description': 'genericDescription',
    };
  }
}
