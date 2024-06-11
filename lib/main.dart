import 'package:flutter/material.dart';
import 'package:full_app/providers/settings_notifier.dart';
import 'package:full_app/services/registr_service.dart';

import 'package:full_app/viewmodel/settings_controller.dart';
import 'package:full_app/views/screens/courses_info_screen.dart';
import 'package:full_app/views/screens/login_screen.dart';
import 'package:full_app/views/screens/main_page.dart';

import 'data/local_data.dart';
import 'models/course_model.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(
    themeModeData: LocalData(),
    sizeTextData: LocalData(),
  );
  await settingsController.loadTheme();
  await settingsController.loadSizeText();
  await settingsController.loadColorText();

  runApp(MainRunner(settingsController: settingsController));
}

class MainRunner extends StatefulWidget {
  final SettingsController settingsController;

  const MainRunner({super.key, required this.settingsController});

  @override
  State<MainRunner> createState() => _MainRunnerState();
}

class _MainRunnerState extends State<MainRunner> {
  final authHttpServices = AuthHttpService();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    authHttpServices.checkAuth().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsNotifier(
      settingsController: widget.settingsController,
      child: Builder(
        builder: (context) {
          final settingsNotifier = SettingsNotifier.of(context);
          return AnimatedBuilder(
            animation: settingsNotifier,
            builder: (context, child) {
              return MaterialApp(
                // routes: {
                //   RouteNames.settingsRoute: (context) => const SettingsScreen(),
                // },
                onGenerateRoute: (settings) {
                  if (settings.name == "/courseInfo") {
                    return MaterialPageRoute(
                        builder: (context) => CourseInfoScreen(
                              course: settings.arguments as Course,
                            ));
                  }
                  return null;
                },
                debugShowCheckedModeBanner: false,
                darkTheme: ThemeData.dark(useMaterial3: true),
                themeMode: settingsNotifier.appTheme.themeMode,
                home: isLoggedIn ? const HomePage() : LoginPage(),
              );
            },
          );
        },
      ),
    );
  }
}
