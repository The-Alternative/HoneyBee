import 'package:honeyBee/models/study/exam.dart';
import 'package:honeyBee/services/study/examservice.dart';

class ExamController {
  final ExamService examService = new ExamService();

  Future<int> saveexam(Exam exam) async {
    return this.examService.saveexam(exam);
  }

  Future<List<Exam>> getAllexam() async {
    return this.examService.getAllexam();
  }

  Future<int> updateexam(Exam exam) async {
    return this.examService.updateExam(exam);
  }

  Future<int> deleteexam(Exam exam) async {
    return this.examService.deleteexam(exam);
  }

  Future<List<Map<String, dynamic>>> getInfo(table) async {
    return this.examService.getInfo(table);
  }

  close() async {
    return await this.examService.close();
  }
}
