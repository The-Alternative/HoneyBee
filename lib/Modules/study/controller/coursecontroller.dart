import '../service/courseService.dart';

import '../model/course.dart';
import '../../../utils/service_locator.dart';

class CourseController {
  CourseService courseService = locator<CourseService>();

  Future<int> saveCourse(Course course) async {
    return this.courseService.saveCourse(course);
  }

  Future<List<Course>> getAllCourse() async {
    return this.courseService.getAllCourse();
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
