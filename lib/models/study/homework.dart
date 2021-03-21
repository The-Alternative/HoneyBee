class HomeWork {
  int id;
  String homeworkcourse, datehomework, timehomework, notehomework;

  HomeWork(
      {this.id,
      this.homeworkcourse,
      this.datehomework,
      this.timehomework,
      this.notehomework});

  factory HomeWork.fromMap(Map<String, dynamic> json) => HomeWork(
        id: json["id"],
        homeworkcourse: json["homeworkcourse"],
        datehomework: json["datehomework"],
        timehomework: json["timehomework"],
        notehomework: json["notehomework"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "homeworkcourse": homeworkcourse,
        "datehomework": datehomework,
        "timehomework": timehomework,
        "notehomework": notehomework,
      };

  HomeWork courseMapToObject(Map<String, dynamic> json) => HomeWork(
        id: json["id"],
        homeworkcourse: json["homeworkcourse"],
        datehomework: json["datehomework"],
        timehomework: json["timehomework"],
        notehomework: json["notehomework"],
      );
}
