import 'package:flutter/material.dart';
import 'package:full_app/viewmodel/todo_viewmodel.dart';

import '../models/todo_model.dart';
import '../views/widgets/manage_todo.dart';


class TodoController extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  TodoController(
      {super.key, required this.onItemTapped, required this.currentIndex});

  @override
  State<TodoController> createState() => _TodoControllerState();
}

class _TodoControllerState extends State<TodoController> {
  final todosViewModel = TodosViewModel();

  void addTodo() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const ManageTodoDialog();
      },
    );

    if (data != null) {
      try {
        todosViewModel.addTodo(
          data['title'],
          data['date'],
          data['isCompleted'],
        );
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  void editTodo(Todo todo) async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return ManageTodoDialog(todo: todo);
      },
    );

    if (data != null) {
      todosViewModel.editTodo(
        todo.id,
        data['title'],
        data['date'],
        data['isCompleted'],
      );
      setState(() {});
    }
  }

  void changeStatus(String id, bool isCompleted) {
    todosViewModel.changeStatus(id, isCompleted);
  }

  void deleteTodo(Todo todo) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: Text("Siz ${todo.title} nomli vazifani o'chirmoqchisiz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ha, ishonchim komil"),
            ),
          ],
        );
      },
    );

    if (response) {
      await todosViewModel.deleteTodo(todo.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: todosViewModel.list,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Rejalar mavjud emas, iltimos qo'shing"),
            );
          }
          final todos = snapshot.data;
          return todos == null || todos.isEmpty
              ? const Center(
            child: Text("Rejalar mavjud emas, iltimos qo'shing"),
          )
              : Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.amber)),
                    leading: todo.isCompleted
                        ? IconButton(
                      onPressed: () {
                        changeStatus(todo.id, !todo.isCompleted);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    )
                        : IconButton(
                      onPressed: () {
                        changeStatus(todo.id, !todo.isCompleted);
                        setState(() {});
                      },
                      icon: const Icon(Icons.circle_outlined),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 2,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                    subtitle: Text(
                      todo.date,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            editTodo(todo);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteTodo(todo);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green,
        onTap: widget.onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart), label: "Statistic"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}