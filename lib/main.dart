import 'package:flutter/material.dart';
import 'package:taskmanager/task_details.dart';
import 'task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.error,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text(
            'Bienvenue dans Task Manager',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: AutofillHints.jobTitle),
          ),
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
