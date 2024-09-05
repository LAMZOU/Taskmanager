import 'package:flutter/material.dart';
import 'package:taskmanager/task.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task, required this.onEdit, required this.onDelete});
  
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      body: Center(
        child: Text(task.title, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}


void _showEditDialog(BuildContext context, Task task) {
  final TextEditingController _controller = TextEditingController(text: task.title);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Task'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter new title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Update the task title
              // Example: task.title = _controller.text;
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );

  void _handleEditTask() {
  // Show edit dialog
  _showEditDialog(context, task);
}

void _handleDeleteTask() {
  // Show confirmation dialog for deletion
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              // Delete the task
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

}

