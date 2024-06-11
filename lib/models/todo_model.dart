
import 'package:json_annotation/json_annotation.dart';
part 'todo_model.g.dart';

@JsonSerializable()
class Todo {
  String id;
  String title;
  String date;
  bool isCompleted;

  Todo(
      {required this.id,
        required this.title,
        required this.date,
        required this.isCompleted});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }
}