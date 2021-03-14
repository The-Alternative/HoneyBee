import 'package:floor/floor.dart';

@entity
class Bmi{

  @PrimaryKey(autoGenerate: true)
  final int id;
  final String height,weight,bmi,date,comment;

  Bmi({this.id, this.height, this.weight, this.bmi, this.date, this.comment});
}