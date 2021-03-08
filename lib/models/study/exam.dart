class Exam {
  int id;
  String namecourse, dateexam, timeexam;

  Exam({this.id, this.namecourse, this.dateexam, this.timeexam});

  factory Exam.fromMap(Map<String, dynamic> json) => Exam(
        id: json["id"],
        namecourse: json["namecourse"],
        dateexam: json["dateexam"],
        timeexam: json["timeexam"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "namecourse": namecourse,
        "dateexam": dateexam,
        "timeexam": timeexam,
      };

  Exam courseMapToObject(Map<String, dynamic> json) => Exam(
        id: json["id"],
        namecourse: json["namecourse"],
        dateexam: json["dateexam"],
        timeexam: json["timeexam"],
      );
}
