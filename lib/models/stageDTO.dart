class StageDTO {
  int stageId;
  String columntitle;
  int taskId;
  //==============================================================================
  StageDTO({this.taskId, this.stageId, this.columntitle});
  //==============================================================================

  Map<String, dynamic> toMap() {
    return {
      "sid": stageId,
      "title": columntitle,
      "tid": taskId,
    };
  }
}
//==============================================================================

class EventDTO {
  int id;
  String title;
  String description;
  String eventDate;
  String time;

  //==============================================================================
  EventDTO({this.id, this.title, this.description, this.eventDate, this.time});
  //==============================================================================

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "eventDate": eventDate,
      "time": time
    };
  }
}
