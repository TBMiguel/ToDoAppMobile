class ToDo {
  int? id;
  String title;
  String description;
  bool done;

  ToDo({
    this.id,
    required this.title,
    required this.description,
    this.done = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done ? 1 : 0,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      done: map['done'] == 1,
    );
  }
}
