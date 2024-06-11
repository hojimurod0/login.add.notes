
import 'package:flutter/material.dart';
import 'package:full_app/utils/note_extension.dart';

import '../../models/note_model.dart';

class ManageNoteScreen extends StatefulWidget {
  Note? notes;
   ManageNoteScreen({super.key, required this.notes});

  @override
  State<ManageNoteScreen> createState() => _ManageExpenseScreenState();
}

class _ManageExpenseScreenState extends State<ManageNoteScreen> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> notesData = {};

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context, notesData);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notes != null) {
      notesData = {
        "title": widget.notes!.title,
        "date": widget.notes!.date,
      };
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.notes == null ? "Eslatma kiritish" : "Eslatma tahrirlash",
        ),
        actions: [
          IconButton(
            onPressed: submit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              initialValue: notesData['title'],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Esatma nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos eslatma nomini kiriting";
                }

                return null;
              },
              onSaved: (value) {
                notesData['title'] = value;
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notesData['date'] == null
                      ? "Eslatma kuni tanlanmagan"
                      : (notesData['date'] as DateTime).format(),
                ),
                TextButton(
                  onPressed: () async {
                    final response = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );

                    if (response != null) {
                      notesData['date'] = response;
                      setState(() {});
                    }
                  },
                  child: const Text("Kunni tanlash"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
