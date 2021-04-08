import 'package:honeyBee/models/study/exam.dart';
import 'package:honeyBee/models/study/homework.dart';

import '../../utils/databaseconfig.dart';

import 'dart:async';

import 'package:sqflite/sqflite.dart';

class HomeWorkService {
  static Database _honeyBee;

  final String homeworks = 'homeworks';
  final String id = 'id';
  final String columnhomeworkcourse = 'homeworkcourse';
  final String columndatehomework = 'datehomework';
  final String columntimehomework = 'timehomework';
  final String columnnotehomework = 'notehomework';

  final DatabaseConfig db = new DatabaseConfig();

  Future<int> savehomework(HomeWork homework) async {
    var dbHomework = await db.honeyBee;
    int result = await dbHomework.insert("$homeworks", homework.toMap());
    print('homework:$result');
    return result;
  }

  Future<List> getAllhomework() async {
    var dbHomework = await db.honeyBee;
    var sql = "SELECT * FROM $homeworks";
    List result = await dbHomework.rawQuery(sql);
    return result.toList();
  }

  Future<int> updateHomework(HomeWork homeWork) async {
    var dbHomework = await db.honeyBee;
    return await dbHomework.update(homeworks, homeWork.toMap(),
        where: "$id", whereArgs: [homeWork.id]);
  }

  Future<int> delethomework(HomeWork homeWork) async {
    var dbHomework = await db.honeyBee;
    return await dbHomework.delete(homeworks, where: "$id = ${homeWork.id}");
  }

  Future<List<Map<String, dynamic>>> getInfo(table) async {
    var db = await this.db.honeyBee;
    var result = await db.query(table);

    return result;
  }

  close() async {
    var dbExam = await db.honeyBee;
    return await dbExam.close();
  }
}
