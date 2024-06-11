
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoRepository {
  final todoHttpService = TodosHttpService();

  Future<List<Todo>> getTodos() async {
    return todoHttpService.getTodos();
  }

  Future<Todo> addTodo(String title, String date, bool isCompleted) async {
    final newTodo = await todoHttpService.addTodo(title, date, isCompleted);
    // productLocalService.addProduct();
    return newTodo;
  }

  Future<void> editTodo(
      String id, String newTitle, String newDate, bool isCompleted) async {
    await todoHttpService.editTodo(id, newTitle, newDate, isCompleted);
  }

  Future<void> deleteTodo(String id) async {
    // Todo delete product
    await todoHttpService.deleteTodo(id);
  }

  Future<void> changeStatus(String id, bool isCompleted)async{
    await todoHttpService.changeStatus(id,isCompleted);
  }
}