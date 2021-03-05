import '../model/development.dart';
import '../service/developmentService/developmentService.dart';
import 'dart:async';
import '../../../utils/service_locator.dart';

class DevelopmentController {


   DevelopmentService developmentService = locator<DevelopmentService>();

  Future<int> saveDevelopment(Development development) async{
    return await this.developmentService.saveDevelopment(development);
  }

  Future<List> getAllDevelopments() async{
    return await this.developmentService.getAllDevelopments();
  }

  Future<List> getChildDevelopments(int id) async{
    return await this.developmentService.getChildDevelopments(id);
  }

  Future<List> searchChildDevelopments(int id,String text) async{
    return await this.developmentService.searchChildDevelopments(id, text);
  }

  Future<List> getChildDevelopment(int id,int developmentId) async{
    return await this.developmentService.getChildDevelopment(id, developmentId);
  }

  Future<int> getDevelopmentsCount () async{
    return await this.developmentService.getDevelopmentsCount();
  }

  Future<Development> getDevelopment (int id) async{
    return await this.developmentService.getDevelopment(id);
  }

  Future<int> updateDevelopment(Development development) async{
    return await this.developmentService.updateDevelopment(development);
  }

  Future<int> deleteDevelopment(Development development) async{
    return await this.developmentService.deleteDevelopment(development);
  }

  close() async{
    return await this.developmentService.close();
  }
}