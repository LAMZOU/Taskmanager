class Task {
  int? id;
  final String title;
  final String content;
  final String priority;
  final String color;
  final DateTime dueDate;

  Task({
    this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.color,
    required this.dueDate,
  });

  // Méthode pour convertir un objet Task en map pour les requêtes HTTP
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'priority': priority,
      'color': color,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  // Méthode pour créer un objet Task à partir d'une map (réponse du backend)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      priority: json['priority'],
      color: json['color'],
      dueDate: DateTime.parse(json['dueDate']),
    );
  }

// Static method to parse a list of tasks from JSON array
static List<Task> fromJsonList(List<dynamic> jsonList) {
return jsonList.map((json) => Task.fromJson(json)).toList();
}
}


