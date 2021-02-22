import 'package:bassel/models/children/habitType.dart';
import 'package:bassel/services/children/habitTypeService.dart';
import 'dart:async';

class HabitTypeController {

  final HabitTypeService habitTypeService = new HabitTypeService();

  Future<int> saveHabitType(HabitType habitType) async{
    return await this.habitTypeService.saveHabitType(habitType);
  }

  Future<List> getAllHabitTypes() async{
    return await this.habitTypeService.getAllHabitTypes();
  }

  Future<int> getHabitTypesCount () async{
    return await this.habitTypeService.getHabitTypesCount();
  }

  Future<HabitType> getHabitType (int id) async{
    return await this.habitTypeService.getHabitType(id);
  }

  Future<int> updateHabitType(HabitType habitType) async{
    return await this.habitTypeService.updateHabitType(habitType);
  }

  Future<int> deleteHabitType(int id) async {
    return await this.habitTypeService.deleteHabitType(id);
  }

  close() async{
    return await this.habitTypeService.close();
  }
}