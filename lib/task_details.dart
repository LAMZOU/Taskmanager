import 'package:flutter/material.dart';
import 'package:taskmanager/task.dart';
import 'package:taskmanager/task_service.dart'; // Assurez-vous d'importer TaskService

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key,
    required this.task,
    required this.onTaskUpdated, // Callback to refresh the task list
    required this.onTaskDeleted, // Callback to refresh the task list
    required this.onEdit, // Callback to edit the task
    required this.onDelete, // Callback to delete the task
  });

  final Task task;
  final VoidCallback onTaskUpdated;
  final VoidCallback onTaskDeleted;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: task.content);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container with text content
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 245, 240, 240),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Contenu de la tâche',
                  border: InputBorder.none,
                ),
                maxLines: null, // Allows multiple lines
              ),
            ),
            const SizedBox(height: 16), // Spacing between the container and buttons
            // Row with buttons
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              height: MediaQuery.of(context).size.height * 0.1, // 10% of screen height
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _handleEditTask(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // White text
                    ),
                    child: Text('Modifier'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleDeleteTask(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red, // White text
                    ),
                    child: Text('Supprimer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleEditTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _titleController = TextEditingController(text: task.title);
        final TextEditingController _contentController = TextEditingController(text: task.content);

        return AlertDialog(
          title: Text('Modifier la tâche'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Entrez un nouveau titre'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(hintText: 'Entrez un nouveau contenu'),
                maxLines: null, // Allows multiple lines
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (task.id == null) {
                  // Handle the case where task ID is null
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tâche invalide')),
                  );
                  Navigator.of(context).pop();
                  return;
                }

                final taskService = TaskService('http://localhost:4000'); // Correctly instantiate TaskService
                final updatedTitle = _titleController.text;
                final updatedContent = _contentController.text;

                bool success = await taskService.updateTask(
                  id: task.id!,
                  title: updatedTitle,
                  content: updatedContent,
                  priority: task.priority,
                  color: task.color,
                  dueDate: task.dueDate,
                );

                if (success) {
                  // Notify the parent to refresh the task list
                  onTaskUpdated();
                  Navigator.of(context).pop();
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur lors de la mise à jour de la tâche')),
                  );
                }
              },
              child: Text('Sauvegarder'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  void _handleDeleteTask(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Supprimer la tâche'),
        content: Text('Êtes-vous sûr de vouloir supprimer cette tâche ?'),
        actions: [
          TextButton(
            onPressed: () async {
              if (task.id == null) {
                // Handle the case where task ID is null
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tâche invalide')),
                );
                Navigator.of(context).pop();
                return;
              }

              final taskService = TaskService('http://localhost:4000'); // Correctly instantiate TaskService

              bool success = await taskService.deleteTask(task.id!);

              if (success) {
                // Notify the parent to refresh the task list
                onTaskDeleted();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('La tâche a été supprimée avec succès')),
                );
                Navigator.of(context).pop();
              } else {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erreur lors de la suppression de la tâche')),
                );
              }
            },
            child: Text('Supprimer'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Annuler'),
          ),
        ],
      );
    },
  );
}
}
