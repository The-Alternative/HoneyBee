
import 'dart:async';

import 'package:bassel/models/medicine/MedicineTimes.dart';
import 'package:bassel/services/medicine/timesDayesService.dart';

class TimesDayesController {

  final TimesDayesService _timesDayesService =  TimesDayesService();

  Future<List<MedicineTimes>> getDayTimesList() async {
    return await this._timesDayesService.getDayTimesList();
  }
  Future<int> insert_DayTimes(MedicineTimes medicineTimes) async {
    return await this._timesDayesService.insert_DayTimes(medicineTimes);

  }
  Future<int> deleteDayTimes( id,  day) async {
    return await this._timesDayesService.deleteDayTimes(id, day);

  }
}