// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/login.dart';
import 'package:taskmanager/Signup.dart';
import 'package:taskmanager/task_list.dart';

const Token="Token";
void main() async{
await WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool hasToken=prefs.getString(Token)!=null;
  runApp(MyApp(hasToken:hasToken));
}


class MyApp extends StatelessWidget{
  final bool hasToken;
  const MyApp({super.key, required this.hasToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: hasToken?TaskList(): LoginPage(),
    );
  }
}