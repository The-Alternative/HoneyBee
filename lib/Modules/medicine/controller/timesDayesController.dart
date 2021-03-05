import 'dart:async';
import '../model/MedicineTimes.dart';
import '../service/timesDayesService/timesDayesService.dart';
import '../../../utils/service_locator.dart';

class TimesDayesController {

  final TimesDayesService _timesDayesService =  locator<TimesDayesService>();

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