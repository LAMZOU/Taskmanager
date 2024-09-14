import 'package:flutter/material.dart';
import 'package:taskmanager/task.dart';
import 'package:taskmanager/task_service.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({
    Key? key,
    required this.task,
    required this.onTaskUpdated,
    required this.onTaskDeleted, required Future<void> Function() onEdit, required Future<void> Function() onDelete,
  }) : super(key: key);

  final Task task;
  final VoidCallback onTaskUpdated;
  final VoidCallback onTaskDeleted;

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late Task _task;
  late TaskService _taskService;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _taskService = TaskService('http://localhost:4000');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_task.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container with text content
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 245, 240, 240),
              ),
              child: SingleChildScrollView(
                child: Text(
                  _task.content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Row with buttons
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _handleEditTask(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Modifier'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleDeleteTask(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
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
        final TextEditingController _titleController = TextEditingController(text: _task.title);
        final TextEditingController _contentController = TextEditingController(text: _task.content);

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
                maxLines: null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_task.id == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tâche invalide')),
                  );
                  Navigator.of(context).pop();
                  return;
                }

                final updatedTitle = _titleController.text;
                final updatedContent = _contentController.text;

                bool success = await _taskService.updateTask(
                  id: _task.id!,
                  title: updatedTitle,
                  content: updatedContent,
                  priority: _task.priority,
                  color: _task.color,
                  dueDate: _task.dueDate,
                );

                if (success) {
                  setState(() {
                    _task = Task(
                      id: _task.id,
                      title: updatedTitle,
                      content: updatedContent,
                      priority: _task.priority,
                      color: _task.color,
                      dueDate: _task.dueDate,
                    );
                  });
                  widget.onTaskUpdated();
                  Navigator.of(context).pop();
                } else {
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
                if (_task.id == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tâche invalide')),
                  );
                  Navigator.of(context).pop();
                  return;
                }

                bool success = await _taskService.deleteTask(_task.id!);

                if (success) {
                  widget.onTaskDeleted();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('La tâche a été supprimée avec succès')),
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
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
