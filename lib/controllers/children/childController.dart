import 'package:bassel/models/children/child.dart';
import 'package:bassel/services/children/childService.dart';
import 'dart:async';

class ChildController {
   ChildService childService = new ChildService() ;


//  Future<int> saveChild(Map x) async{
//  return this.childService.saveChild(x);
//  }
  Future<int> saveChild(Child child) async{
    return await this.childService.saveChild(child);
  }

  Future<List> getAllChild() async{
    return await this.childService.getAllChild();
  }

  Future<int> getChildCount () async{
    return await this.childService.getChildCount();
  }

  Future<Child> getChild (int id) async{
    return await this.childService.getChild(id);
  }

//  Future<int> updateChild(Map x) async{
//    return this.childService.updateChild(x);
//  }
  Future<int> updateChild(Child child) async{
    return await this.childService.updateChild(child);
  }

  Future<int> deleteChild(Child child) async{
    return await this.childService.deleteChild(child);
  }

   close() async{
     return await this.childService.close();
  }
}