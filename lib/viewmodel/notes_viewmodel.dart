import 'package:full_app/services/note_database.dart';

import '../models/note_model.dart';

class NotesViewmodel {
  final _notesDatabase = NoteDatabase();

  List<Note> _list = [];

  Future<List<Note>> list(DateTime date) async {
    _list = await _notesDatabase.getNotes(date);
    return [..._list];
  }

  Future<void> addNote(String title, DateTime date) async {
    await _notesDatabase.addNote({
      "title": title,
      "date": date.toString(),
    });
  }

  Future<void> editNote(
    int id,
    String title,
    DateTime date,
  ) async {
    await _notesDatabase.editNote(
      id,
      {
        "title": title,
        "date": date.toString(),
      },
    );
  }

  Future<void> deleteNote(int id) async {
    await _notesDatabase.deleteNote(id);
  }
}
