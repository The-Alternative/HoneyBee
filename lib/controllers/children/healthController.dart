import 'package:bassel/models/children/health.dart';
import 'package:bassel/services/children/healthService.dart';
import 'dart:async';

class HealthController {
  final HealthService healthService = new HealthService();


  Future<int> saveHealth(Health health) async{
    int x = await this.healthService.saveHealth(health);
    return x;
  }

  Future<List> getAllHealth() async{
    return await this.healthService.getAllHealth();
  }

  Future<List> getChildHealths(int id) async{
    return await this.healthService.getChildHealths(id);
  }

  Future<List> searchChildHealths(int id,String text) async{
    return await this.healthService.searchChildHealths(id,text);
  }

  Future<List> getChildHealth(int id,int healthId) async{
    return await this.healthService.getChildHealth(id, healthId);
  }

  Future<int> getHealthCount () async{
    return await this.healthService.getHealthCount();
  }

  Future<Health> getHealth (int id) async{
    return await this.healthService.getHealth(id);
  }

  Future<int> updateHealth(Health health) async{
    return await this.healthService.updateHealth(health);
  }

  Future<int> deleteHealth(Health health) async{
    return await this.healthService.deleteHealth(health);
  }

  close() async{
    return await this.healthService.close();
  }
}