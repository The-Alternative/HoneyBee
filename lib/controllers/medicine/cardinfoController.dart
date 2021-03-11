
import 'package:HoneyBee/models/medicine/MedicineInfo.dart';
import 'package:HoneyBee/services/medicine/cardinfoService.dart';
import 'dart:async';

class CardinfoController {

  final CardinfoService _cardinfoService =  CardinfoService();

  Future<List<MedicineInfo>> getSelectCards(String name) async{
    return await this._cardinfoService.getAllTimes(name);
  }

}