import 'package:HoneyBee/models/study/course.dart';
import 'package:HoneyBee/services/study/courseservice.dart';

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

  close() async {
    return await this.courseService.close();
  }
}
