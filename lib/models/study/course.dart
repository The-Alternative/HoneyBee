class Course {
  int id;
  String namecourse;
  String nameteachar;
  String email;
  String teacharnumber;
  String image;

  Course(
      {this.id,
      this.namecourse,
      this.nameteachar,
      this.email,
      this.teacharnumber,
      this.image});

  Course.Without();

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"],
        namecourse: json["namecourse"],
        nameteachar: json["nameteachar"],
        email: json["email"],
        teacharnumber: json["teacharnumber"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "namecourse": namecourse,
        "nameteachar": nameteachar,
        "email": email,
        "teacharnumber": teacharnumber,
        "image": image,
      };
  Course courseMapToObject(Map<String, dynamic> json) => Course(
        id: json["id"],
        namecourse: json["namecourse"],
        nameteachar: json["nameteachar"],
        email: json["email"],
        teacharnumber: json["teacharnumber"],
        image: json["image"],
      );
}
