class Note {
  int? id;
  String title;
  String content;
  int color; // Store color as an integer (Color value)

  Note({
    this.id,
    required this.title,
    required this.content,
    this.color = 0xFFFFFFFF, // Default color (white)
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      color: map['color'] ?? 0xFFFFFFFF,
    );
  }
}