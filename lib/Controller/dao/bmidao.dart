import 'package:floor/floor.dart';
import 'package:honeyBee/models/entity/bmi.dart';
@dao
abstract class BmiDAO{
  @Query ('SELECT * FROM Bmi')
  Future<List<Bmi>> getAllItemInBmiByUid();

@Query ('DELETE FROM Bmi WHERE id =:id')
Future<void> clearBmiById( int id);


@insert
  Future<int> insertBmi( Bmi bmi);

@update
Future<int>  updateBmi( Bmi bmi  );
}
