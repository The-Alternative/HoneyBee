import '../model/course.dart';

abstract class CourseService{
  Future<int> saveCourse(Course course);
  Future<List> getAllCourse();
  Future<int> updateCourse(Course course);
  Future<int> deleteCourse(Course course);
  Future<List<Map<String, dynamic>>> getInfo(table);
  close();
}