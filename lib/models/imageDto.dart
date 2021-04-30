class ImgModel {
  int imgId;
  String path;
  int taskId;
  //==============================================================================

  ImgModel({
    this.imgId,
    this.path,
    this.taskId,
  });
  //==============================================================================

  factory ImgModel.fromMap(Map<String, dynamic> json) => ImgModel(
        imgId: json["imgid"],
        path: json["path"],
        taskId: json["tid"],
      );
  //==============================================================================

  ImgModel medicineMapToObject(Map<String, dynamic> json) => ImgModel(
        imgId: json["imgid"],
        path: json["path"],
        taskId: json["tid"],
      );
  //==============================================================================

  Map<String, dynamic> toMap() => {
        "name": path,
        "tid": taskId,
      };
}
