import '../model/bmimodels.dart';

abstract class DescService {
  Future<int> saveDesc(CardInfo cardInfo);
  Future<List<CardInfo>> getAll();
  deleteobj(int id);
  close();
}