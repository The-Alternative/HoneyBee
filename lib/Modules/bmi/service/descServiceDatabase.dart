import '../model/bmimodels.dart';

import '../../../utils/databaseconfig.dart';
import 'descService.dart';

class DescServiceDatabase extends DescService{

  final String descTable = 'descTable';
  final String cloumnId = 'id';
  final String cloumnHeight = 'height';
  final String cloumnWeight = 'weight';
  final String cloumnBmi = 'bmi';
  final String cloumnDate = 'date';
  final String columnComment = 'comment';
  final DatabaseConfig db = new DatabaseConfig();

  @override
  close() async {
    // TODO: implement close
    var dbClient = await db.honeyBee;
    return await dbClient.close();
  }

  @override
  deleteobj(int id) async {
    // TODO: implement deleteobj
    var dbClient = await db.honeyBee;
    int result = await dbClient.rawDelete('DELETE FROM $descTable WHERE $cloumnId = $id');
    return result;
  }

  @override
  Future<List<CardInfo>> getAll() async {
    // TODO: implement getAll
    List<CardInfo> _cardlist = [];
    var dbClient = await db.honeyBee;
    var result = await dbClient.query(descTable);
    result.forEach((element) {
      var card = CardInfo.fromMap(element);
      _cardlist.add(card);
    });

    return _cardlist;
  }

  @override
  Future<int> saveDesc(CardInfo cardInfo) async {
    // TODO: implement saveDesc
    var dbClient = await db.honeyBee;
    int result = await dbClient.insert("$descTable", cardInfo.toMap());
    return result;
  }

}