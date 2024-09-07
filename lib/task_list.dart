import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/user_profile.dart';
import 'add_task_page.dart';
import 'task.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'ajouter le package intl à votre pubspec.yaml
import 'task_service.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<Task> _tasks = [];

  final taskService = TaskService('http://localhost:4000');


  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  UserProfilePage(),
                  ),
                );
              },
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.error,
          title: const Text(
            'Bienvenue dans Task Manager',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
              fontFamily: AutofillHints.jobTitle,
            ),
          ),
        ),
floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskPage(
                  onTaskAdded: _addTask, taskService: taskService,
                ),
              ),
            );
          },
          label: const Text('Ajouter'),
          icon: const Icon(
            Icons.add,
            color: Colors.red,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey,
          child: Container(
            height: 20.0,
          ),
          
      ),
      body: _tasks.isEmpty? 
      Center(child: Text('Pas de tache ajouter pour le moment')):
       ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(
                    '${task.content}\n'
                    'Priority: ${task.priority}\n'
                    'Color: ${task.color}\n'
                    'Due: ${DateFormat.yMMMd().format(task.dueDate)}', // Format de date plus lisible
                  ),
                  // Optionnel : Ajouter un Divider pour améliorer la lisibilité
                  // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  // isThreeLine: true,
                );
              },
            ),
    );
  }
}
