class TaskInfo {
  int noticeId;
  int taskId;
  int stageId;
  int personId;
  String name;
  String columntitle;
  String noticeTitle;
  String columnPath1;
  String columnPath2;
  //==============================================================================
  TaskInfo(
      {this.noticeId,
      this.taskId,
      this.personId,
      this.stageId,
      this.noticeTitle,
      this.columntitle,
      this.name,
      this.columnPath1,
      this.columnPath2});
  //==============================================================================
  factory TaskInfo.fromMap(Map<String, dynamic> json) => TaskInfo(
      taskId: json["tid"],
      noticeId: json["nid"],
      personId: json["pid"],
      stageId: json["sid"],
      noticeTitle: json["cnotice"],
      columntitle: json["tt"],
      columnPath1: json['path1'],
      columnPath2: json['path2'],
      name: json["name"]);

}
