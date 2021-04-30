class Stage {
  final int stageId;
  final String columntitle;
  final int taskId;
  //==============================================================================

  Stage({this.stageId, this.taskId, this.columntitle});
  //==============================================================================
  factory Stage.fromMap(Map data) {
    return Stage(
      stageId: data['sid'],
      columntitle: data['title'],
      taskId: data['tid'],
    );
  }
  //==============================================================================
  factory Stage.fromJson(int id, Map<String, dynamic> data) {
    return Stage(
      stageId: id,
      columntitle: data['title'],
      taskId: data['tid'],
    );
  }
  //==============================================================================
  Map<String, dynamic> toMap() {
    return {
      "sid": stageId,
      "title": columntitle,
      "tid": taskId,
    };
  }
}
