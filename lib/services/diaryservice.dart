// import 'package:flutter_app/models/diary.dart';
// import 'package:flutter_app/utils/database.dart';
// import 'package:sqflite/sqflite.dart';
//
//
// class DiaryService{
//   static Database _honeyBee;
//
//   final String diaryTable = 'diary';
//   final String columnId = 'id';
//   final String columnAddress = 'address';
//   final String columnPost = 'post';
//   final String columnDate = 'date';
//   final String columnImage = 'image';
//
//   final DatabaseConfig db = new DatabaseConfig();
//
//   Future<int> saveDesc(Diary diary) async{
//     var dbClient = await db.honeyBee;
//     int result = await dbClient.insert("$diaryTable", diary.toMap());
//     return result;
//   }
//   Future<List<Diary>> getAll() async {
//     List<Diary> _cardlist = [];
//     var dbClient = await db.honeyBee;
//     var result = await dbClient.query(diaryTable);
//     result.forEach((element) {
//       var diary = Diary.fromMap(element);
//       _cardlist.add(diary);
//     });
//
//     return _cardlist;
//   }
//
//   Future<int> deleteobj(int id) async {
//     var dbClient = await db.honeyBee;
//     int result = await dbClient.rawDelete('DELETE FROM $diaryTable WHERE $columnId = $id');
//     return result;
//   }
//
//   close() async{
//     var dbClient = await db.honeyBee;
//     return await dbClient.close();
//   }
// }