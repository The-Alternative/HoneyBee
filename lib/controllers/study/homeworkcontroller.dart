import 'package:honeyBee/models/study/homework.dart';
import 'package:honeyBee/services/study/homeworkservice.dart';

class HomeWorkController {
  final HomeWorkService homeworkService = new HomeWorkService();

  Future<int> savehomework(HomeWork homework) async {
    return this.homeworkService.savehomework(homework);
  }

  Future<List<HomeWork>> getAllhomework() async {
    return this.homeworkService.getAllhomework();
  }

  Future<int> updateHomework(HomeWork homework) async {
    return this.homeworkService.updateHomework(homework);
  }

  Future<int> deletehomework(HomeWork homework) async {
    return this.homeworkService.delethomework(homework);
  }

  Future<List<Map<String, dynamic>>> getInfo(table) async {
    return this.homeworkService.getInfo(table);
  }

  close() async {
    return await this.homeworkService.close();
  }
}
