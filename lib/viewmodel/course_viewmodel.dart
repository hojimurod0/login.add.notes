import '../models/course_model.dart';
import '../models/lesson_model.dart';
import '../repository/course_repository.dart';

class CourseViewModel {
  final CourseRepository _courseRepository = CourseRepository();

  Future<List<Course>> get courseList async {
    return [...await _courseRepository.getCoursesRepo()];
  }

  Future<List<Course>> addCourse({
    required String courseTitle,
    required String courseDescription,
    required String courseImageUrl,
    required List<Lesson> courseLessons,
    required num coursePrice,
  }) async {
    await _courseRepository.addCourse(
      courseTitle: courseTitle,
      courseDescription: courseDescription,
      courseImageUrl: courseImageUrl,
      courseLessons: courseLessons,
      coursePrice: coursePrice,
    );
    return await _courseRepository.getCoursesRepo();
  }

  Future<void> deleteCourse({required String id}) async {
    await _courseRepository.deleteCourse(id: id);
  }
}
