import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/task.dart';
import 'package:taskmanager/task_details.dart';
import 'package:taskmanager/user_profile.dart';
import 'package:taskmanager/add_task_page.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});
  


  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> _tasks = sampleTask;

  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
                  onTaskAdded: _addTask,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: ListView.builder(
          padding: const EdgeInsets.all(50.0),
          itemCount: _tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskItem(
              task: _tasks[index],
              goTo: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetails(task: _tasks[index], onEdit: () {  }, onDelete: () {  },),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class TaskItem extends StatelessWidget {
  final Task task;
  final Function() goTo;

  const TaskItem({super.key, required this.task, required this.goTo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goTo,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    task.date,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            const Icon(
              Icons.star,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

