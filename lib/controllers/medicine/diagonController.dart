import 'package:bassel/services/medicine/cardinfoService.dart';
import 'package:bassel/services/medicine/diagonService.dart';
import 'dart:async';

class DiagonController {

  final DiagonService _diagonService =  DiagonService();

  Future<int> insertDiagon(diagon ) async{
    return await this._diagonService.insertDiagon(diagon);
  }

}