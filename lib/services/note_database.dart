
import '../models/note_model.dart';
import 'local_database.dart';

class NoteDatabase {
  final _localDatabase = LocalDatabase();
  final _tableName = "notes";

  Future<List<Note>> getNotes(DateTime date) async {
    final db = await _localDatabase.database;
    final rows = await db.query(
      _tableName);
    List<Note> notes = [];

    for (var row in rows) {
      notes.add(
        Note.fromMap(row),
      );
    }

    return notes;
  }

  Future<void> addNote(Map<String, dynamic> noteData) async {
    final db = await _localDatabase.database;
    await db.insert(_tableName, noteData);
  }

  Future<void> editNote(int id, Map<String, dynamic> noteData) async {
    final db = await _localDatabase.database;
    await db.update(
      _tableName,
      noteData,
      where: "id = $id",
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await _localDatabase.database;
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
