import 'package:flutter/material.dart';
import 'View/ListNote.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'MySimpleNote',
  theme: ThemeData(primarySwatch: Colors.blue),
  home: NoteList(),
  );
  }
  }
