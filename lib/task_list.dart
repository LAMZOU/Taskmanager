import 'package:flutter/material.dart';
import 'package:taskmanager/task.dart';
import 'package:taskmanager/task_details.dart';
import 'package:taskmanager/user_profile.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          title: const Text(
            'Bienvenue dans Task Manager',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
                fontFamily: AutofillHints.jobTitle),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserProfilePage(), // Naviguer vers la page de profil utilisateur
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: const FloatingActionButton.extended(
          onPressed: (null),
          label: Text('ajouter'),
          icon: Icon(
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
          itemCount: sampleTask.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskItem(
              task: sampleTask[index],
              goTo: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TaskDetails(task: sampleTask[index])));
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
