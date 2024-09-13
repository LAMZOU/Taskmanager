// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
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
  final _colorController = TextEditingController();
  final _dueDateController = TextEditingController();
  var _priority = 'Medium';

  Future<void> _submit() async {
    final title = _titleController.text;
    final content = _contentController.text;
    final priority = _priority;
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
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: _priority,
              decoration: const InputDecoration(
                  labelText: 'Priority',
                  hintText: 'Select the priority of the task',
                  border: OutlineInputBorder()),
              items: ['High', 'Medium', 'Low']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _priority = newValue!;
                });
              },
            ),
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            Container(
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.width / 3,
                child: Center(
                    child: TextField(
                  controller: _dueDateController,
//editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true,
//set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
//DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package => 2021-03-16
                      setState(() {
                        _dueDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ))),
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
