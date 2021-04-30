class NoticeModel {
  int noticeId;
  String noticeTitle;
  int taskId;
  //==============================================================================

  NoticeModel({
    this.noticeId,
    this.noticeTitle,
    this.taskId,
  });
  //==============================================================================

  factory NoticeModel.fromMap(Map<String, dynamic> json) => NoticeModel(
        noticeId: json["nid"],
        noticeTitle: json["cnotice"],
        taskId: json["tid"],
      );
  //==============================================================================

  NoticeModel medicineMapToObject(Map<String, dynamic> json) => NoticeModel(
        noticeId: json["nid"],
        noticeTitle: json["cnotice"],
        taskId: json["tid"],
      );
  //==============================================================================

  Map<String, dynamic> toMap() => {
        "cnotice": noticeTitle,
        "tid": taskId,
      };
}
