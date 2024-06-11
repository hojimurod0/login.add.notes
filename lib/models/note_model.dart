
class Note {
  final int id;
  String title;
  DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.date,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'].toString(),
      date: DateTime.parse(
        map['date'],
      ),
    );
  }
}
