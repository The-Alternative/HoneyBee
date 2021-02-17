final List<String> dayes_list = ['السبت', 'الأحد', 'الأثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];
final List<String> types_list = ['يوم', 'أسبوع', 'شهر'];
class Entry{
  static String pat_name;
  static String doct_name;
  static String  times_num;
  static String code;
  static int incAmount;
  static String first_date;
  static String first_clock;
  static String teratment_days;
  static String instruc;
  static String pain;
  static String imgPath;

  static bool Req =false;
  static bool Res =true;
  static List<Datee> info;
}
class Datee{
  String date;
  String time;
  Datee(this.date,this.time);
}
