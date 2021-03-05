import '../../model/child.dart';

abstract class ChildServic{
  Future<int> saveChild(Child child);
  Future<List> getAllChild();
  Future<int> getChildCount ();
  Future<Child> getChild (int id);
  Future<int> updateChild(Child child);
  Future<int> deleteChild(Child child);
  close();

}