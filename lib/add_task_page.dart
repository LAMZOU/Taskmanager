import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'task.dart';
import 'task_service.dart'; // Importez le service

class AddTaskPage extends StatefulWidget {
  final Function(Task) onTaskAdded;
  final TaskService taskService; // Ajoutez une instance de TaskService

  const AddTaskPage({
    super.key,
    required this.onTaskAdded,
    required this.taskService, // Passez l'instance de TaskService
  });

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _priorityController = TextEditingController();
  final _colorController = TextEditingController();
  final _dueDateController = TextEditingController();

  Future<void> _submit() async {
    final title = _titleController.text;
    final content = _contentController.text;
    final priority = _priorityController.text; // Garder la priorité en tant que String
    final color = _colorController.text;
    final dueDate = DateTime.tryParse(_dueDateController.text);

    if (title.isEmpty || content.isEmpty || color.isEmpty || dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields with valid data')),
      );
      return;
    }

    final newTask = Task(
      title: title,
      content: content,
      priority: priority, // Convertir en entier pour le modèle Task
      color: color,
      dueDate: dueDate,
    );

    try {
      final success = await widget.taskService.addTask(
        title: title,
        content: content,
        priority: priority, // Passer la priorité en tant que String
        color: color,
        dueDate: dueDate,
      );

      if (success) {
        widget.onTaskAdded(newTask);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add task')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            TextField(
              controller: _priorityController,
              decoration: const InputDecoration(labelText: 'Priority'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            TextField(
              controller: _dueDateController,
              decoration: const InputDecoration(labelText: 'Due Date (YYYY-MM-DDTHH:MM:SSZ)'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
