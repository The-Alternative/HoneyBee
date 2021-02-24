
import 'package:bassel/models/medicine/MedicineInfo.dart';
import 'package:bassel/utils/databaseconfig.dart';
import 'package:sqflite/sqflite.dart';

class CardinfoService{
  String medicinTable = 'med_table';
  String medId = 'id'; //primry/forign..key
  String medTitle = 'title';
  //////////////////////////////////////////////////
  String diagonTable = 'diagon_table';
  String diagid = 'd_id'; //primry/forign..key
  String doctname = 'd_name';
  String medAmount = 'amount';
  String instruction = 'description';
  String diagon = 'diagon';
  String img_direct = 'img_direct';
  String times = 'times';
  String dayes = 'dayes';
  String first_date = 'fdate';
  String last_date = 'ldate';
  String first_clock = 'fclock';
  String notice = 'notic';
  //////////////////////////////////////////////////
  String patientTable = 'patent_table';
  String patname = 'p_name';
  String patId = 'p_id'; //primry/forign..key
  //////////////////////////////////////////////////
  String midDayesTable = 'mDayes_table';
  String dayesId = 'day_id';
  String day_date = 'd_date';
  String sortNum = 'sortn';

  /////////////////////////////////////////////////////////
  String dayTimesTable = 'mTimes_table';
  String timesId = 'tid';
  String day_time = 'd_time';
  String day_time_state = 'd_t_state';
  DatabaseConfig _medicineDatabase = DatabaseConfig();
  static Database _database;
  //
  // //init database
  // Future<Database> get database async{
  //   if(_database != null) return _database;
  //   _database = await _medicineDatabase.setDatabase();
  //   return _database;
  // }

/////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getptname(int id, String name) async {
    Database db = await this._medicineDatabase.honeyBee;
    List<Map> result;
    if (name == '')
      result = await db.rawQuery(
          'SELECT $patname,$medTitle,$img_direct,$diagon,$first_date,$doctname,$notice,$diagonTable.$diagid as dgid,$medAmount,'
              ' $midDayesTable.$dayesId as dayid,$dayTimesTable.$timesId as tmid,$day_time'
              ',$day_time_state,$day_date,$sortNum'
              ' FROM $patientTable,$medicinTable,$diagonTable,$dayTimesTable,$midDayesTable WHERE '
              '$midDayesTable.$dayesId = $dayTimesTable.$dayesId '
              'AND $dayTimesTable.$diagid = $diagonTable.$diagid '
              'AND $diagonTable.$patId = $patientTable.$patId '
              'AND $diagonTable.$medId = $medicinTable.$medId '
              'AND $dayTimesTable.$timesId = $id  order By $sortNum ASC');
    else
      result = await db.rawQuery(
          'SELECT $patname,$medTitle,$img_direct,$diagon,$first_date,$doctname,$notice,$diagonTable.$diagid as dgid,$medAmount,'
              ' $midDayesTable.$dayesId as dayid,$dayTimesTable.$timesId as tmid,$day_time'
              ',$day_time_state,$day_date,$sortNum'
              ' FROM $patientTable,$medicinTable,$diagonTable,$dayTimesTable,$midDayesTable'
              ' WHERE '
              '$midDayesTable.$dayesId = $dayTimesTable.$dayesId '
              'AND $dayTimesTable.$diagid =  $diagonTable.$diagid '
              'AND $diagonTable.$patId = $patientTable.$patId '
              'AND $diagonTable.$medId = $medicinTable.$medId '
              'AND $dayTimesTable.$timesId = $id '
              'AND $patientTable.$patname =? '
              'order By $sortNum ASC',
          ['$name']);
    return result;
  }

  Future<List<MedicineInfo>> getAllTimes(String name) async {
    List<MedicineInfo> cardList = List<MedicineInfo>();
    cardList.clear();
    Database db = await this._medicineDatabase.honeyBee;
    List<Map> result = await db.rawQuery('SELECT $timesId FROM $dayTimesTable');
    List<int> ids = List<int>();
    // get each row in the result list and print it
    result.forEach((row) {
      int a = row['$timesId'];
      ids.add(a);
    });

    for (var i = 0; i < ids.length; i++) {
      //print(ids.elementAt(i));
      var cardMapList = await getptname(
          ids.elementAt(i), name); // Get 'Map List' from database
      // int count = cardMapList.length; // Count the number of map entries in db table
      MedicineInfo cardObject = MedicineInfo();
      if (cardMapList.length != 0) {
        cardObject = MedicineInfo.fromMap(cardMapList[0]);
        cardList.add(cardObject);
      }
    }
    return cardList;
  }
//////////////////////////////////////////////////////////////////////////////////////
}