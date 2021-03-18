import 'package:diary/models/diary.dart';
import 'package:diary/utils/database.dart';
import 'package:sqflite/sqflite.dart';


class DiaryService{
  static Database _honeyBee;

  final String diaryTable = 'diary';
  final String columnId = 'id';
  final String columnAddress = 'address';
  final String columnDescription = 'description';
  final String columnDate = 'date';
  final String columnImage = 'image';


  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveDiary(Diary diary) async{
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$diaryTable", diary.toMap());
    return result;
  }

  Future<List> searchDiary(int id,String text) async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $diaryTable Where $columnId = $id AND ($columnAddress LIKE '%$text%')";
    List result = await dbClient.rawQuery(sql);
    return result.toList();

  }

  Future<List<Diary>> getAll() async {
    List<Diary> _cardlist = [];
    var dbClient = await db.honeyBee;
    var result = await dbClient.query(diaryTable,orderBy: '$columnId DESC');
    result.forEach((element) {
      var diary = Diary.fromMap(element);
      _cardlist.add(diary);
    });
    return _cardlist;
  }

  Future<List<Diary>> getdiaryList() async{
    var get = await getDiaryMapList();
    int count = get.length;

    List<Diary> diarys = new List<Diary>();
    for(int i ; i == count ; i++){
      diarys.add(Diary.fromMap(get[i]));
    }
    return diarys;
  }


  Future<List<Map<String, dynamic>>> getDiaryMapList() async{
    var dbClient = await db.honeyBee;
    var result = await dbClient.query(diaryTable,orderBy:"$columnId DESC ");
    return result;
  }

  Future<List> getAllDiary() async{
    var dbClient = await db.honeyBee;
    var sql ="SELECT * FROM $diaryTable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> updateDiary(Diary diary) async{
    var dbClient = await db.honeyBee;
    var result = await dbClient.update(diaryTable, diary.toMap(),
        where: "$columnId = ? ",whereArgs: [diary.id]);
    return result;
  }


  Future<int> deleteobj(int id) async {
    var dbClient = await db.honeyBee;
    int result = await dbClient.rawDelete('DELETE FROM $diaryTable WHERE $columnId = $id');
    return result;
  }
  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}