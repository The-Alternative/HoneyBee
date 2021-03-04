
import 'dart:async';

import '../model/MedicineTimes.dart';
import '../service/timesDayesService.dart';

class TimesDayesController {

  final TimesDayesService _timesDayesService =  TimesDayesService();

  Future<List<MedicineTimes>> getDayTimesList() async {
    return this._timesDayesService.getDayTimesList();
  }
  insert_DayTimes(MedicineTimes medicineTimes)  {
    this._timesDayesService.insert_DayTimes(medicineTimes);

  }
  Future<int> deleteDayTimes( id,  day) async {
    return this._timesDayesService.deleteDayTimes(id, day);

  }
}