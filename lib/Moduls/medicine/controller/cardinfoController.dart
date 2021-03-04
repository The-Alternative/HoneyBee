
import '../model/MedicineInfo.dart';
import '../service/cardinfoService.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class CardinfoController {

  final CardinfoService _cardinfoService =  CardinfoService();

  Future<List<MedicineInfo>> getSelectCards(String name) async{
    return await this._cardinfoService.getAllTimes(name);
  }

}