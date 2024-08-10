import 'package:flutter/material.dart';
import 'package:taskmanager/task.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task, });
  final Task task;
  @override
  Widget build(BuildContext context) {
    return  Center(
      
      child: Text(task.title),
      
             
    );
  }
}
