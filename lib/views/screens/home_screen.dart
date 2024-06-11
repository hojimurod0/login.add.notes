import 'package:flutter/material.dart';

import 'package:full_app/viewmodel/course_viewmodel.dart';
import 'package:full_app/views/screens/todos_screen.dart';

import '../../models/course_model.dart';
import '../widgets/drawer_page.dart';
import '../widgets/listview_container.dart';
import 'notes_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  HomeScreen(
      {super.key, required this.onItemTapped, required this.currentIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _courseViewModel = CourseViewModel();
  bool _isViewStylePressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodosScreen(
                                onItemTapped: widget.onItemTapped,
                                currentIndex: widget.currentIndex)));
                  },
                  child: const Card(
                    child: Center(
                        child: Text(
                      "Todos",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotesScreen()));
                  },
                  child: const Card(
                    child: Center(
                        child: Text("Notes",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24))),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _courseViewModel.courseList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Center(child: Text('error: ${snapshot.error}'));
                } else {
                  List<Course> courseList = snapshot.data;
                  return _isViewStylePressed
                      ? GridView.builder(
                          itemCount: courseList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.3,
                          ),
                          itemBuilder: (context, index) =>
                              CustomListViewBuilderContainer(
                            isViewStylePressed: _isViewStylePressed,
                            course: courseList[index],
                            isDelete: false,
                          ),
                        )
                      : ListView.builder(
                          itemCount: courseList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CustomListViewBuilderContainer(
                            isViewStylePressed: _isViewStylePressed,
                            course: courseList[index],
                            isDelete: false,
                          ),
                        );
                }
              },
            ),
          ),
        ],
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
