import 'package:flutter/material.dart';
import 'package:full_app/utils/note_extension.dart';
import 'package:full_app/views/widgets/manage_note.dart';
import 'package:full_app/views/widgets/note_item.dart';

import '../../models/note_model.dart';
import '../../utils/routes_utild.dart';
import '../../viewmodel/notes_viewmodel.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NotesScreen> {
  final notesViewModel = NotesViewmodel();
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
  }

  void addNote() async {
    final response = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ManageNoteScreen(notes: null)));

    if (response != null) {
      await notesViewModel.addNote(
        (response as Map)['title'],
        response['date'],
      );
      setState(() {});
    }
  }

  void editNote(Note note) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManageNoteScreen(
                  notes: note,
                )));

    if (response != null) {
      await notesViewModel.editNote(
        note.id,
        (response as Map)['title'],
        response['date'],
      );
      setState(() {});
    }
  }

  void deleteNote(Note note) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: Text("Siz ${note.title} eslatmani o'chirmoqchisiz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ha, ishonchim komil"),
            ),
          ],
        );
      },
    );

    if (response) {
      await notesViewModel.deleteNote(note.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: addNote,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              final response = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
                initialDate: selectedDate,
              );
              if (response != null) {
                selectedDate = response;
                setState(() {});
              }
            },
            child: Text(
              selectedDate.format(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: notesViewModel.list(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                final notes = snapshot.data;
                return notes == null || notes.isEmpty
                    ? const Center(
                        child: Text("Eslatmalar mavjud emas."),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: notes.length,
                        itemBuilder: (ctx, index) {
                          return NoteItem(
                              note: notes[index],
                              onEdit: () {
                                editNote(notes[index]);
                              },
                              onDelete: () {
                                deleteNote(notes[index]);
                              });
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
