import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/login.dart';
import 'package:taskmanager/signup.dart'; // Corrected import to match the class name
import 'package:taskmanager/task_list.dart';
import 'package:taskmanager/user_profile.dart';

const String Token = "Token";

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool hasToken = prefs.getString(Token) != null;
  runApp(MyApp(hasToken: hasToken));
}

class MyApp extends StatelessWidget {
  final bool hasToken;

  const MyApp({super.key, required this.hasToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: hasToken ? '/task-list' : '/login',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginPage());
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignUpScreen());
          case '/task-list':
            return MaterialPageRoute(builder: (_) => TaskList());
          case '/user-profile':
            return MaterialPageRoute(builder: (_) => UserProfilePage());
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(child: Text('Page not found')),
              ),
            );
        }
      },
    );
  }
}
