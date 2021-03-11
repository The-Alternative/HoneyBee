

import 'package:floor/floor.dart';
import 'package:honeyBee/dao/bmidao.dart';
import 'package:honeyBee/entity/bmi.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'bmiDatabase.g.dart';
@Database(version: 1, entities: [Bmi])
abstract class AppDatabase extends FloorDatabase{
  BmiDAO get bmiDAO;
}
