
import 'dart:async';
import '../../../utils/service_locator.dart';
import '../model/bmimodels.dart';
import '../service/descService.dart';

class DescController {
  final DescService descService = locator<DescService>();

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