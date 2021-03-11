import 'package:HoneyBee/models/bmi/bmimodels.dart';
import 'package:HoneyBee/utils/databaseconfig.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DescService {

  static Database _honeyBee ;

  final String descTable = 'descTable';
  final String cloumnId = 'id';
  final String cloumnHeight = 'height';
  final String cloumnWeight = 'weight';
  final String cloumnBmi = 'bmi';
  final String cloumnDate = 'date';
  final String columnComment = 'comment';



  final DatabaseConfig db = new DatabaseConfig();

  Future<int> saveDesc(CardInfo cardInfo) async{
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$descTable", cardInfo.toMap());
    return result;
  }
  Future<List<CardInfo>> getAll() async {
    List<CardInfo> _cardlist = [];
    var dbClient = await db.honeyBee;
    var result = await dbClient.query(descTable);
    result.forEach((element) {
      var card = CardInfo.fromMap(element);
      _cardlist.add(card);
    });

    return _cardlist;
  }

  Future<int> deleteobj(int id) async {
    var dbClient = await db.honeyBee;
    int result = await dbClient.rawDelete('DELETE FROM $descTable WHERE $cloumnId = $id');
    return result;
  }

  close() async{
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }
}