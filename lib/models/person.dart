class PersonModel {
  int personId;
  String name;
  int taskId;
  //==============================================================================

  PersonModel({
    this.personId,
    this.name,
    this.taskId,
  });
  //==============================================================================

  factory PersonModel.fromMap(Map<String, dynamic> json) => PersonModel(
        personId: json["pid"],
        name: json["name"],
        taskId: json["tid"],
      );
  //==============================================================================

  PersonModel medicineMapToObject(Map<String, dynamic> json) => PersonModel(
        personId: json["pid"],
        name: json["name"],
        taskId: json["tid"],
      );
  //==============================================================================

  Map<String, dynamic> toMap() => {
        "name": name,
        "tid": taskId,
      };
}
