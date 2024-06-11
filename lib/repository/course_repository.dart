import '../models/course_model.dart';
import '../models/lesson_model.dart';
import '../services/course_service.dart';

class CourseRepository {
  final CourseHttpService _courseHttpService = CourseHttpService();

  Future<List<Course>> getCoursesRepo() async {
    return await _courseHttpService.getData();
  }

  Future<void> addCourse({
    required String courseTitle,
    required String courseDescription,
    required String courseImageUrl,
    required List<Lesson> courseLessons,
    required num coursePrice,
  }) async {
    await _courseHttpService.addCourse(
      courseTitle: courseTitle,
      courseDescription: courseDescription,
      courseImageUrl: courseImageUrl,
      courseLessons: courseLessons,
      coursePrice: coursePrice,
    );
  }

  Future<void> deleteCourse({required String id}) async {
    await _courseHttpService.deleteCourse(id: id);
  }
}
