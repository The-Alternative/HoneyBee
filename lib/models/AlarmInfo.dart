class AlarmInfo {
  int id;
  int taskId;
  String title;
  DateTime alarmDateTime;
  bool isPending;
  //==============================================================================
  AlarmInfo({
    this.id,
    this.taskId,
    this.title,
    this.alarmDateTime,
    this.isPending,
  });
  //==============================================================================
  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        taskId: json["d_id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
      );
  //==============================================================================
  Map<String, dynamic> toMap() => {
        "id": id,
        "d_id": taskId,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
      };
}
//==============================================================================

class alarmObject {
  int diagonId;
  DateTime alarmDate;

  alarmObject({this.diagonId, this.alarmDate});
}
