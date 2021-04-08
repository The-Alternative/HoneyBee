import 'package:honeyBee/models/study/program.dart';
import 'package:honeyBee/services/study/programservice.dart';

class ProgramController {
  final ProgramService programService = new ProgramService();

  Future<int> saveprogram(Program program) async {
    return this.programService.saveprogram(program);
  }

  Future<List<Program>> getAllprogram() async {
    return this.programService.getAllprogram();
  }

  Future<int> updateprogram(Program program) async {
    return this.programService.updateprogram(program);
  }

  Future<int> deleteprogram(Program program) async {
    return this.programService.deleteprogram(program);
  }

  Future<List<Map<String, dynamic>>> getInfo(table) async {
    return this.programService.getInfo(table);
  }

  close() async {
    return await this.programService.close();
  }
}
