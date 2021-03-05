import '../../../utils/service_locator.dart';
import 'dart:async';

import '../service/diagonService/diagonService.dart';

class DiagonController {

  final DiagonService _diagonService = locator<DiagonService>();

  Future<int> insertDiagon(diagon ) async{
    return this._diagonService.insertDiagon(diagon);
  }
  Future<int> updateDiagon( diagon) async {
    return this._diagonService.updateDiagon(diagon);

  }
}