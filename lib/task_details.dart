import 'package:flutter/material.dart';
import 'package:taskmanager/task.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: task.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: 350.0,
                height: MediaQuery.of(context).size.height * 2 / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 210, 209, 209),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'content',
                      border: InputBorder.none,
                    ),
                    maxLines: null, // Allows multiple lines
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onEdit,
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: onDelete,
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        ],
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
}

void _handleEditTask(BuildContext context, Task task) {
  // Show edit dialog
  _showEditDialog(context, task);
}

void _handleDeleteTask(BuildContext context) {
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
