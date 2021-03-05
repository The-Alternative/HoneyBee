
import 'dart:async';
import '../../../utils/service_locator.dart';
import '../model/medicineDays.dart';
import '../service/medicineDayService/medicineDayService.dart';

class MedicineDayController {
  final MedicineDayService _medicineDayinfoService = locator<MedicineDayService>();

  Future<List<Map<String, dynamic>>> getmidDayesMapList(name) async {
    return this._medicineDayinfoService.getmidDayesMapList(name);
  }
  Future<int> insertDayes( days) async {
    return this._medicineDayinfoService.insertDayes(days);
  }
  Future<List<MedicineDays>> getselectmidDayesList( name) async {
    return this._medicineDayinfoService.getselectmidDayesList(name);

  }
  Future<int> updateDayTimes( medicineTimes) async {
    return this._medicineDayinfoService.updateDayTimes(medicineTimes);

  }



}