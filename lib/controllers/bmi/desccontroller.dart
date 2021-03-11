
import 'dart:async';

import 'package:HoneyBee/models/bmi/bmimodels.dart';
import 'package:HoneyBee/services/bmi/descservice.dart';

class DescController {
  final DescService descService = new DescService();

  Future<int> saveDesc(CardInfo cardInfo) async{
    return this.descService.saveDesc(cardInfo);
  }
  Future<List<CardInfo>> getAll() async{
    return this.descService.getAll();
  }

  Future<int> deleteobj(int i) async{
    return this.descService.deleteobj(i);
  }
  close() async{
    return this.descService.close();
  }
}