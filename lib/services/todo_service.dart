import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodosHttpService {
  Future<List<Todo>> getTodos() async {
    Uri url =
        Uri.parse("https://todos-388d6-default-rtdb.firebaseio.com/todos.json");

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    List<Todo> loadedTodos = [];
    if (data != null) {
      data.forEach((key, value) {
        value["id"] = key;

        loadedTodos.add(Todo.fromJson(value));
      });
    }
    print(loadedTodos);
    return loadedTodos;
  }

  Future<Todo> addTodo(String title, String date, bool isCompleted) async {
    Uri url =
        Uri.parse("https://todos-388d6-default-rtdb.firebaseio.com/todos.json");

    Map<String, dynamic> todoData = {
      "title": title,
      "date": date,
      "isCompleted": isCompleted,
    };
    final response = await http.post(
      url,
      body: jsonEncode(todoData),
    );

    Todo newTodo = Todo.fromJson(todoData);
    return newTodo;
  }

  Future<void> editTodo(
    String id,
    String newTitle,
    String newDate,
    bool isCompleted,
  ) async {
    Uri url = Uri.parse(
        "https://todos-388d6-default-rtdb.firebaseio.com/todos/$id.json");

    Map<String, dynamic> todoData = {
      "title": newTitle,
      "date": newDate,
      "isCompleted": isCompleted,
    };
    final response = await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }

  Future<void> deleteTodo(String id) async {
    Uri url = Uri.parse(
        "https://todos-388d6-default-rtdb.firebaseio.com/todos/$id.json");

    await http.delete(url);
  }

  Future<void> changeStatus(String id, bool isCompleted) async {
    Uri url = Uri.parse(
        "https://todos-388d6-default-rtdb.firebaseio.com/todos/$id.json");

    Map<String, dynamic> tododata = {"isCompleted": isCompleted};
    final response = await http.patch(url, body: jsonEncode(tododata));
  }
}
