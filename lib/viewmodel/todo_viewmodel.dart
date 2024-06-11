
import '../models/todo_model.dart';
import '../repository/todo_repository.dart';

class TodosViewModel {
  final todosRepository = TodoRepository();

  List<Todo> _list = [];

  Future<List<Todo>> get list async {
    _list = await todosRepository.getTodos();
    return [..._list];
  }

  Future<void> addTodo(String title, String date, bool isCompleted) async {
    final newTodo = await todosRepository.addTodo(title, date, isCompleted);
    _list.add(newTodo);
  }

  Future<void> editTodo(String id, String newTitle, String newdate, bool isCompleted) async {
    todosRepository.editTodo(id, newTitle, newdate, isCompleted);
    final index = _list.indexWhere((todo) {
      return todo.id == id;
    });

    _list[index].title = newTitle;
    _list[index].date = newdate;
    _list[index].isCompleted = isCompleted;
  }

  Future<void> deleteTodo(String id) async {
    await todosRepository.deleteTodo(id);
    _list.removeWhere((todo) {
      return todo.id == id;
    });
  }

  Future<void> changeStatus (String id, bool isCompleted)async{
    todosRepository.changeStatus(id, isCompleted);

  }
}