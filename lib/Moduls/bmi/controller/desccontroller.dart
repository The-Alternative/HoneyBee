
import 'dart:async';

import '../model/bmimodels.dart';
import '../service/descservice.dart';

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