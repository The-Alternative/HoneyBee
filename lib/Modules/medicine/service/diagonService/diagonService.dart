import '../../model/Diagon.dart';

abstract class DiagonService{
  Future<List<Map<String, dynamic>>> getDiagonMapList();
  Future<int> insertDiagon(Diagon diagon);
  Future<int> updateDiagon(Diagon diagon);
  Future<int> deleteDiagon(int id);
  Future<int> getCountDiagon();
  Future<List<Diagon>> getDiagonList();

}