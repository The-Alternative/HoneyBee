import '../models/diary.dart';
import '../services/diaryservice.dart';

class DiaryController {
  final DiaryService diaryService = new DiaryService();


  Future<int> saveDiary(Diary diary) async{
    return this.diaryService.saveDiary(diary);
  }

  Future<List<Diary>> getAll() async{
    return this.diaryService.getAll();
  }

  Future<List> getAllDiary() async{
    return await this.diaryService.getAllDiary();
  }

  Future<List> searchDiary(int id,String text)async{
    return this.diaryService.searchDiary(id, text);
  }

  Future<int> updateDiary(Diary diary) async{
    return await this.diaryService.updateDiary(diary);
  }
  Future<List<Diary>> getdiaryList()async{
    return await this.diaryService.getdiaryList();
  }

  Future<int> deleteobj(int i) async{
    return this.diaryService.deleteobj(i);
  }

  close() async{
    return this.diaryService.close();
  }
}