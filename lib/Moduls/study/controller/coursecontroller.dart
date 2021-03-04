import '../model/course.dart';
import '../service/courseservice.dart';

class CourseController {
  final CourseService courseService = new CourseService();

  Future<int> saveCourse(Course course) async {
    return this.courseService.saveCourse(course);
  }

  Future<List<Course>> getAllcourse() async {
    return this.courseService.getAllcourse();
  }

  Future<int> updateCourse(Course course) async {
    return this.courseService.updateCourse(course);
  }

  Future<int> deleteCourse(Course course) async {
    return this.courseService.deleteCourse(course);
  }

  Future<List<Map<String, dynamic>>> getInfo(table) async {
    return this.courseService.getInfo(table);
  }

  close() async {
    return await this.courseService.close();
  }
}
