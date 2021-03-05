
import '../model/MedicineInfo.dart';
import '../service/cardinfoService/cardinfoService.dart';
import 'dart:async';
import '../../../utils/service_locator.dart';

class CardinfoController {

  final CardinfoService _cardinfoService = locator<CardinfoService>();

  Future<List<MedicineInfo>> getSelectCards(String name) async{
    return await this._cardinfoService.getAllTimes(name);
  }

}