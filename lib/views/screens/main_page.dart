import 'package:flutter/material.dart';
import 'package:full_app/views/screens/profile_screen.dart';
import 'package:full_app/views/screens/statistic_screen.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        HomeScreen(onItemTapped: _onItemTapped, currentIndex: _currentIndex),
        StatisticScreen(
            onItemTapped: _onItemTapped, currentIndex: _currentIndex),
        ProfileScreen(onItemTapped: _onItemTapped, currentIndex: _currentIndex),
      ],
    );
  }
}
