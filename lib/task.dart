class Task {
  final String title;
  final String content;
  final String priority;
  final String color;
  final DateTime dueDate;

  Task({
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
      title: json['title'],
      content: json['content'],
      priority: json['priority'],
      color: json['color'],
      dueDate: DateTime.parse(json['dueDate']),
    );
  }
}
