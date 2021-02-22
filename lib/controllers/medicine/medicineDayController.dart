import 'package:bassel/models/medicine/medicineDays.dart';
import 'package:bassel/services/medicine/medicineDayService.dart';
import 'dart:async';

class MedicineDayController {
  final MedicineDayService _medicineDayinfoService =  MedicineDayService();

  Future<List<Map<String, dynamic>>> getmidDayesMapList() async {
    return await this._medicineDayinfoService.getmidDayesMapList();
  }
  Future<int> insertDayes( days) async {
    return await this._medicineDayinfoService.insertDayes(days);
  }
  Future<List<MedicineDays>> getselectmidDayesList( name) async {
    return await this._medicineDayinfoService.getselectmidDayesList(name);

  }
  Future<int> updateDayTimes( medicineTimes) async {
    return await this._medicineDayinfoService.updateDayTimes(medicineTimes);

  }



}