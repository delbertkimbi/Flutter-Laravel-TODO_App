class Todo {
  int id;
  String title;
  String description;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'] == 1,
    );
  }

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'title': title,
    'description': description,
    'completed': completed ? 1 : 0, // Convert boolean to 0/1
  };
}

}
