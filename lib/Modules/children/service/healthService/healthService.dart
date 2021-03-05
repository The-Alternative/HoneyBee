import '../../model/health.dart';

abstract class HealthService{
  Future<int> saveHealth(Health health);
  Future<List> getAllHealth();
  Future<List> getChildHealths(int id);
  Future<List> searchChildHealths(int id,String text);
  Future<List> getChildHealth(int id,int healthId);
  Future<int> getHealthCount ();
  Future<Health> getHealth (int id);
  Future<int> updateHealth(Health health);
  Future<int> deleteHealth(Health health);
  close();
}