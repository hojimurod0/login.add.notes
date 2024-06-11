import 'package:full_app/views/screens/notes_screen.dart';
import 'package:full_app/views/widgets/manage_note.dart';

class RouteNames {
  static String settingsRoute = "/settings";
  static String todosRoute = "/todos";
  static const String courseInfo = '/courseInfo';
  static const String home = "/";
  static const String manageExpense = "/manage-expense";
}

class AppRoute {
  static final routes = {
    RouteNames.home: (ctx) => const NotesScreen(),
  };
}
