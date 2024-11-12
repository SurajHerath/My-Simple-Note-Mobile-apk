import 'package:flutter/material.dart';
import '../Controller/NoteController.dart';
import '../Model/Note.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _controller = NoteController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  Color _selectedColor = Colors.white;

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty) {
      _showAlert("Title Missing", "Please add a title for your note.");
      return;
    }
    if (_contentController.text.isEmpty) {
      _showAlert("Content Missing", "Please add content for your note.");
      return;
    }

    final newNote = Note(
      title: _titleController.text,
      content: _contentController.text,
      color: _selectedColor.value,
    );
    await _controller.addNote(newNote);
    Navigator.of(context).pop();
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _colorSelectionRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Colors.primaries.map((color) {
          return GestureDetector(
            onTap: () => setState(() => _selectedColor = color),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _selectedColor == color ? Colors.black : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.white12,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.yellowAccent),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            SizedBox(height: 10),
            _colorSelectionRow(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}