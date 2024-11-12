

import 'package:flutter/material.dart';
import '../Controller/NoteController.dart';
import '../Model/Note.dart';


class EditNotePage extends StatefulWidget {
  final Note note;
  EditNotePage({required this.note});

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _controller = NoteController();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Color _selectedColor;
  bool _isEditable = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedColor = Color(widget.note.color);
    super.initState();
  }

  Future<void> _updateNote() async {
    if (_titleController.text.isEmpty) {
      _showAlert("Title Missing", "Please add a title for your note.");
      return;
    }
    if (_contentController.text.isEmpty) {
      _showAlert("Content Missing", "Please add content for your note.");
      return;
    }

    widget.note.title = _titleController.text;
    widget.note.content = _contentController.text;
    widget.note.color = _selectedColor.value;
    await _controller.updateNote(widget.note);
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
        title: Text(
          _isEditable ? 'Edit Note' : 'View Note', // Dynamic title based on edit mode
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.white12,
        actions: [
          if (!_isEditable)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white70),
              onPressed: () {
                setState(() {
                  _isEditable = true;
                });
              },
            ),
          if (_isEditable)
            IconButton(
              icon: Icon(Icons.save, color: Colors.white70),
              onPressed: _updateNote,
            ),
        ],
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
              readOnly: !_isEditable,
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
                readOnly: !_isEditable,
              ),
            ),
            SizedBox(height: 10),
            if (_isEditable) _colorSelectionRow(), // Only show color selection in edit mode
            SizedBox(height: 20),
            if (_isEditable)
              ElevatedButton(
                onPressed: _updateNote,
                child: Text('Save'),
              ),
          ],
        ),
      ),
    );
  }
}
