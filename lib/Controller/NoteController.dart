import '../Model/Note.dart';
import '../Service/DatabaseHelper.dart';


class NoteController {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Note>> getAllNotes() async {
    final data = await dbHelper.queryAllNote();
    return data.map((item) => Note.fromMap(item)).toList();
  }

  Future<void> addNote(Note note) async {
    await dbHelper.insertNote(note.toMap());
  }

  Future<void> updateNote(Note note) async {
    await dbHelper.updateNote(note.toMap());
  }

  Future<void> deleteNote(int id) async {
    await dbHelper.deleteNote(id);
  }

  Future<List<Note>> searchNotes(String query) async {
    final allNotes = await getAllNotes();
    return allNotes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

}
