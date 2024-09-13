import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/task_details.dart';
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
  Future<List<Task>> _tasks = Future.value([]);

  final taskService = TaskService('http://localhost:4000');

  // Method to fetch tasks
  Future<void> _fetchTasks() async {
    setState(() {
      _tasks = taskService.fetchTasks();
    });
  }

  void _addTask(Task task) {
    _fetchTasks(); // Refresh the task list after adding a task
  }

  @override
  void initState() {
    _fetchTasks(); // Fetch tasks when the widget is initialized
    super.initState();
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
                  builder: (context) => UserProfilePage(),
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
                onTaskAdded: _addTask,
                taskService: taskService,
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
      body: FutureBuilder<List<Task>>(
        future: _tasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('La liste des tâches est vide'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final task = snapshot.data![index];
                  String priorityImagePath;

                  // Déterminez le chemin de l'image en fonction de la priorité
                  switch (task.priority) {
                    case 'High':
                      priorityImagePath = 'images/high.png';
                      break;
                    case 'Medium':
                      priorityImagePath = 'images/medium.png';
                      break;
                    case 'Low':
                      priorityImagePath = 'images/low.png';
                      break;
                    default:
                      priorityImagePath = 'images/low.png'; // Valeur par défaut
                  }

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetails(
                            task: task,
                            onEdit: _fetchTasks, // Pass the refresh callback
                            onDelete: _fetchTasks, // Pass the refresh callback
                            onTaskUpdated: _fetchTasks, // Pass the refresh callback
                            onTaskDeleted: _fetchTasks, // Pass the refresh callback
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          // Conteneur principal de la tâche
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '${DateFormat('dd-MM').format(task.dueDate)}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          // Indicateur de priorité à droite du conteneur
                          Image.asset(
                            priorityImagePath,
                            width: 40,
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Une erreur est survenue'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
