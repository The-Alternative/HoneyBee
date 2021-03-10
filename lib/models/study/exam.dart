class Exam {
  int id;
  String examcourse, dateexam, timeexam;

  Exam({this.id, this.examcourse, this.dateexam, this.timeexam});

  factory Exam.fromMap(Map<String, dynamic> json) => Exam(
        id: json["id"],
        examcourse: json["examcourse"],
        dateexam: json["dateexam"],
        timeexam: json["timeexam"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "examcourse": examcourse,
        "dateexam": dateexam,
        "timeexam": timeexam,
      };

  Exam courseMapToObject(Map<String, dynamic> json) => Exam(
        id: json["id"],
        examcourse: json["examcourse"],
        dateexam: json["dateexam"],
        timeexam: json["timeexam"],
      );
}
