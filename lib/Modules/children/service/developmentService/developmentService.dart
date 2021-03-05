import '../../model/development.dart';

abstract class DevelopmentService{
  Future<int> saveDevelopment(Development development);
  Future<List> getAllDevelopments();
  Future<List> getChildDevelopments(int id);
  Future<List> searchChildDevelopments(int id,String text);
  Future<List> getChildDevelopment(int id,int developmentId);
  Future<int> getDevelopmentsCount ();
  Future<Development> getDevelopment (int id);
  Future<int> updateDevelopment(Development development);
  Future<int> deleteDevelopment(Development development);
  close();
}