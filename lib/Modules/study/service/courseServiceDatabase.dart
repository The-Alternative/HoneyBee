import '../model/course.dart';

import 'courseService.dart';
import '../../../utils/databaseconfig.dart';

class CourseServiceDatabase extends CourseService{

  final String courses = 'courses';
  final String columnid = 'id';
  final String columnnamecourse = 'namecourse';
  final String columnnameteachar = 'nameteachar';
  final String columnemail = 'email';
  final String columnteacharnumber = 'teacharnumber';
  final String columnimage = 'image';
  final DatabaseConfig db = new DatabaseConfig();

  @override
  close() async {
    // TODO: implement close
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }

  @override
  Future<int> deleteCourse(Course course)async {
    // TODO: implement deleteCourse
    var dbClient = await db.honeyBee;
    return await dbClient.delete(courses, where: "$columnid = ${course.id}");
  }

  @override
  Future<List> getAllCourse() async {
    // TODO: implement getAllCourse
    var dbClient = await db.honeyBee;
    var sql = "SELECT * FROM $courses";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  @override
  Future<List<Map<String,dynamic>>> getInfo(table) async {
    // TODO: implement getInfo
    var db = await this.db.honeyBee;
    var result = await db.query(table);

    return result;
  }

  @override
  Future<int> saveCourse(Course course) async {
    // TODO: implement saveCourse
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$courses", course.toMap());

    print(result);

    print('basel:$result');

    return result;
  }

  @override
  Future<int> updateCourse(Course course) async {
    // TODO: implement updateCourse
    var dbClient = await db.honeyBee;
    return await dbClient.update(courses, course.toMap(),
        where: "$columnid", whereArgs: [course.id]);
  }

}