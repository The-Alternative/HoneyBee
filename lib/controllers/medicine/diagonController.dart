
import 'dart:async';

import 'package:HoneyBee/services/medicine/diagonService.dart';

class DiagonController {

  final DiagonService _diagonService =  DiagonService();

  Future<int> insertDiagon(diagon ) async{
    return this._diagonService.insertDiagon(diagon);
  }
  Future<int> updateDiagon( diagon) async {
    return this._diagonService.updateDiagon(diagon);

  }
}