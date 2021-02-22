import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseConfig {
  static Database _honeyBee;
  final String courses = 'courses';
  final String descTable = 'descTable';
  final String columnid = 'id';
  final String columnnamecourse = 'namecourse';
  final String columnnameteachar = 'nameteachar';
  final String columnemail = 'email';
  final String columnteacharnumber = 'teacharnumber';
  final String columnimage = 'image';
  /////////////////////////////BMI////////////////////////////////////////////
  final String cloumnId = 'id';
  final String cloumnHeight = 'height';
  final String cloumnWeight = 'weight';
  final String cloumnBmi = 'bmi';
  final String cloumnDate = 'date';
  final String columnComment = 'comment';
  //////////////////////////////////CHildrenDiary///////////////////
  final String childTable = 'childTable';
  // final String cloumnId = 'id';
  final String cloumnName = 'name';
  final String cloumnSex = 'sex';
  final String cloumnBirthDate = 'birthDate';
  final String cloumnImage = 'image';
  final String cloumnIsActive = 'isActive';
  final String healthTable = 'healthTable';
  final String eventTable = 'eventTable';
  final String tablesTable = 'tablesTable';
  final String developmentTable = 'developmentTable';
  final String habitTable = 'habitTable';
  final String habitTypeTable = 'habitTypeTable';
  final String childHabitTable = 'childHabitTable';
  final String mediaTable = 'mediaTable';
  final String cloumnNote = 'note';
  final String cloumnTall = 'tall';
  // final String cloumnWeight = 'weight';
  final String cloumnTempreture = 'tempreture';
  final String cloumnCreatedDate = 'createdDate';
  final String cloumnChildId = 'childId';
  final String cloumnTypeId = 'typeId';
  final String cloumnHabitId = 'habitId';
  final String cloumnMediaUrl = 'mediaUrl';
  final String cloumnTableId = 'tableId';
  final String cloumnItemId = 'itemId';
  ////////////////////////////////////////medicin//////////////
  String medicinTable = 'med_table';
  String medicinView = 'med_view';
  String medId = 'id'; //primry/forign..key
  String medTitle = 'title';
  String medform = 'form';
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

  String dayTimesTable = 'mTimes_table';
  String timesId = 'tid';
  String day_time = 'd_time';
  String day_time_state = 'd_t_state';

  /////////////////////////////////////////////////////////

  Future<Database> get honeyBee async {
    if (_honeyBee != null) {
      return _honeyBee;
    }
    _honeyBee = await intDb();
    return _honeyBee;
  }

  intDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, 'honeyBee.db');
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _oncreate);
    return myOwnDb;
  }

  void _oncreate(Database db, int newVersion) async {
    var coursesql =
        "CREATE TABLE $courses($columnid INTEGER PRIMARY KEY, $columnnamecourse TEXT ,$columnnameteachar TEXT , $columnemail TEXT , $columnteacharnumber TEXT , $columnimage TEXT)";
    await db.execute(coursesql);
    var descsql = "CREATE TABLE $descTable ($cloumnId INTEGER PRIMARY KEY ,"
        "$cloumnHeight TEXT,$cloumnWeight TEXT,$cloumnBmi TEXT,$cloumnDate TEXT,$columnComment TEXT)";
    await db.execute(descsql);
    var childSql = "CREATE TABLE $childTable ($cloumnId INTEGER PRIMARY KEY ,"
        "$cloumnName TEXT,$cloumnSex TEXT,$cloumnBirthDate TEXT,$cloumnImage TEXT,$cloumnIsActive INTEGER)";
    await db.execute(childSql);
    var healthSql = "CREATE TABLE $healthTable ($cloumnId INTEGER PRIMARY KEY ,"
        "$cloumnName TEXT , $cloumnNote TEXT , $cloumnTall INTEGER , $cloumnWeight INTEGER ,"
        "$cloumnTempreture INTEGER , $cloumnIsActive INTEGER , $cloumnCreatedDate TEXT , $cloumnChildId INTEGER ,"
        "FOREIGN KEY ($cloumnChildId) REFERENCES $childTable ($cloumnId))";
    await db.execute(healthSql);
    var eventSql = "CREATE TABLE $eventTable ($cloumnId INTEGER PRIMARY KEY ,"
        "$cloumnName TEXT , $cloumnNote TEXT , $cloumnTall INTEGER , $cloumnWeight INTEGER ,"
        "$cloumnTempreture INTEGER , $cloumnIsActive INTEGER , $cloumnCreatedDate TEXT , $cloumnChildId INTEGER ,"
        "FOREIGN KEY ($cloumnChildId) REFERENCES $childTable ($cloumnId))";
    await db.execute(eventSql);
    var developmentSql = "CREATE TABLE $developmentTable ($cloumnId INTEGER PRIMARY KEY ,"
        "$cloumnName TEXT , $cloumnNote TEXT , $cloumnTall INTEGER , $cloumnWeight INTEGER ,"
        "$cloumnTempreture INTEGER , $cloumnIsActive INTEGER , $cloumnCreatedDate TEXT , $cloumnChildId INTEGER ,"
        "FOREIGN KEY ($cloumnChildId) REFERENCES $childTable ($cloumnId))";
    await db.execute(developmentSql);
    var habitSql = "CREATE TABLE $habitTable ($cloumnId INTEGER PRIMARY KEY ,"
        "$cloumnName TEXT ,"
        " $cloumnIsActive INTEGER , $cloumnCreatedDate TEXT , $cloumnTypeId INTEGER ,"
        "FOREIGN KEY ($cloumnTypeId) REFERENCES $habitTypeTable ($cloumnId))";
    await db.execute(habitSql);
    var habitTypeSql = "CREATE TABLE $habitTypeTable ($cloumnId INTEGER PRIMARY KEY ,$cloumnName TEXT )";
    await db.execute(habitTypeSql);
    var childHabitSql = "CREATE TABLE $childHabitTable ($cloumnId INTEGER PRIMARY KEY ,"
        " $cloumnIsActive INTEGER , $cloumnCreatedDate TEXT , $cloumnHabitId INTEGER ,$cloumnChildId INTEGER )";
    await db.execute(childHabitSql);
    var mediaSql = "CREATE TABLE $mediaTable ($cloumnId INTEGER PRIMARY KEY ,"
        "$cloumnMediaUrl TEXT ,"
        " $cloumnCreatedDate INTEGER , $cloumnTableId INTEGER ,$cloumnItemId INTEGER ,"
        "FOREIGN KEY ($cloumnTableId) REFERENCES $tablesTable ($cloumnId))";
    await db.execute(mediaSql);
    await db.execute(
        'CREATE TABLE '
            '$medicinTable($medId INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$medTitle TEXT UNIQUE, '
            '$medform TEXT)');
    await db.execute(
        'CREATE TABLE'
            ' $patientTable($patId INTEGER PRIMARY KEY AUTOINCREMENT,'
            ' $patname TEXT UNIQUE)');
    await db.execute(
        'CREATE TABLE $diagonTable($diagid INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$doctname TEXT, $medAmount INTEGER, $diagon TEXT,$instruction TEXT,$first_date TEXT,$first_clock TEXT,'
            '$dayes TEXT,$times TEXT,$img_direct TEXT,$notice TEXT'
            ',$medId INTEGER FORIGN KEY REFERENCES $medicinTable($medId),'
            '$patId INTEGER FORIGN KEY REFERENCES $patientTable($patId))');
    await db.execute(
        'CREATE TABLE'
            ' $midDayesTable($dayesId INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$day_date TEXT UNIQUE,'
            '$sortNum int)');
    await db.execute(
        'CREATE TABLE'
            ' $dayTimesTable($timesId INTEGER PRIMARY KEY AUTOINCREMENT, $day_time TEXT,'
            '$day_time_state int,'
            '$dayesId INTEGER FORIGN KEY REFERENCES $midDayesTable($dayesId),'
            '$diagid INTEGER FORIGN KEY REFERENCES $diagonTable($diagid) )');

    await db.execute(
        'CREATE TABLE'
            ' $medicinView($medId INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$medTitle TEXT UNIQUE, '
            '$medform TEXT,'
            '$diagid INTEGER,'
            '$patname TEXT,'
            '$img_direct TEXT'
            ',$first_date TEXT,'
            '$first_clock TEXT,'
            '$doctname TEXT,'
            '$patId INTEGER,'
            '$diagon TEXT,'
            '$notice TEXT,'
            '$medAmount TEXT,'
            '$last_date TEXT)');


  }
}
