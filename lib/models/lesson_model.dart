import 'package:full_app/models/quiz_model.dart';

class Lesson {
  final int courseId;
  final int lessonId;
  String lessonTitle;
  String lessonDescription;
  String videoUrl;
  List<Quiz> lessonQuiz;

  Lesson({
    required this.lessonId,
    required this.courseId,
    required this.lessonTitle,
    required this.lessonDescription,
    required this.videoUrl,
    required this.lessonQuiz,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lesson-id'],
      courseId: json['course-id'],
      lessonTitle: json['lesson-title'],
      lessonDescription: json['lesson-description'],
      videoUrl: json['lesson-videourl'],
      lessonQuiz: (json['lesson-quiz'] as List)
          .map((quiz) => Quiz.fromJson(quiz as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lesson-id': lessonId,
      'course-id': courseId,
      'lesson-title': lessonTitle,
      'lesson-description': lessonDescription,
      'lesson-videourl': videoUrl,
      'lesson-quiz': lessonQuiz,
    };
  }
}
