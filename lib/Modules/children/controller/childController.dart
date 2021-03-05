import '../model/child.dart';
import 'dart:async';
import '../service/childService/childService.dart';
import '../../../utils/service_locator.dart';

class ChildController {
  ChildServic _childService =  locator<ChildServic>() ;


//  Future<int> saveChild(Map x) async{
//  return this.childService.saveChild(x);
//  }
  Future<int> saveChild(Child child) async{
    return await this._childService.saveChild(child);
  }

  Future<List> getAllChild() async{
    return await this._childService.getAllChild();
  }

  Future<int> getChildCount () async{
    return await this._childService.getChildCount();
  }

  Future<Child> getChild (int id) async{
    return await this._childService.getChild(id);
  }

//  Future<int> updateChild(Map x) async{
//    return this.childService.updateChild(x);
//  }
  Future<int> updateChild(Child child) async{
    return await this._childService.updateChild(child);
  }

  Future<int> deleteChild(Child child) async{
    return await this._childService.deleteChild(child);
  }

   close() async{
     return await this._childService.close();
  }
}