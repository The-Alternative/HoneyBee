class AlarmInfo {
  int id;
  int diag;
  String title;
  DateTime alarmDateTime;
  bool isPending;

  AlarmInfo(
      {this.id,
        this.diag,
        this.title,
        this.alarmDateTime,
        this.isPending,
      });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
    id: json["id"],
    diag: json["d_id"],
    title: json["title"],
    alarmDateTime: DateTime.parse(json["alarmDateTime"]),
    isPending: json["isPending"],

  );
  Map<String, dynamic> toMap() => {
    "id": id,
    "d_id":diag,
    "title": title,
    "alarmDateTime": alarmDateTime.toIso8601String(),
    "isPending": isPending,
  };
}

class alarmObject {
  int diagonId;
  DateTime alarmDate;
  alarmObject({this.diagonId, this.alarmDate});
}
