class Program {
  int id;
  String course, dateprogram, timeprogram, noteprogram, title, subtitle;

  Program(
      {this.id,
      this.course,
      this.dateprogram,
      this.timeprogram,
      this.noteprogram,
      this.subtitle,
      this.title});

  factory Program.fromMap(Map<String, dynamic> json) => Program(
        id: json["id"],
        course: json["course"],
        dateprogram: json["dateprogram"],
        timeprogram: json["timeprogram"],
        noteprogram: json["noteprogram"],
        subtitle: json["subtitle"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "course": course,
        "dateprogram": dateprogram,
        "timeprogram": timeprogram,
        "noteprogram": noteprogram,
        "subtitle": subtitle,
        "title": title,
      };

  Program courseMapToObject(Map<String, dynamic> json) => Program(
        id: json["id"],
        course: json["course"],
        dateprogram: json["dateprogram"],
        timeprogram: json["timeprogram"],
        noteprogram: json["noteprogram"],
        subtitle: json["subtitle"],
        title: json["title"],
      );
}
