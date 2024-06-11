import 'package:flutter/material.dart';

import '../../viewmodel/todo_viewmodel.dart';
import '../widgets/drawer_page.dart';

class StatisticScreen extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  const StatisticScreen(
      {super.key, required this.onItemTapped, required this.currentIndex});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final todosViewModel = TodosViewModel();

  Future<Map<String, int>> countTasks() async {
    final todos = await todosViewModel.list;
    int done = todos.where((todo) => todo.isCompleted).length;
    return {
      "total": todos.length,
      "completed": done,
      "notCompleted": todos.length - done,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text("Statistic Screen",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, int>>(
        future: countTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final counts = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Umumiy Takslar soni:  ${counts['total']}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow),
                ),
                Text(
                  "Bajarilgan vazifalar:  ${counts['completed']}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  "Bajarilmagan:  ${counts['notCompleted']}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          );
        },
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