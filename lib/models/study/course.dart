class Course {
  int id;
  String namecourse;
  String nameteachar;
  String email;
  String teacharnumber;

  Course(
      {this.id,
      this.namecourse,
      this.nameteachar,
      this.email,
      this.teacharnumber});

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"],
        namecourse: json["namecourse"],
        nameteachar: json["nameteachar"],
        email: json["email"],
        teacharnumber: json["teacharnumber"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "namecourse": namecourse,
        "nameteachar": nameteachar,
        "email": email,
        "teacharnumber": teacharnumber,
      };
}
