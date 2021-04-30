class EventDTO {
  int id;
  String title;
  String description;
  String piriority;
  String eventDate;
  int tcase;
  String time;
  String columnPlaces;
  String columnPath1;
  String columnPath2;
  //==============================================================================
  EventDTO(
      {this.id,
      this.title,
      this.columnPlaces,
      this.tcase,
      this.description,
      this.piriority,
      this.eventDate,
      this.time,
      this.columnPath1,
      this.columnPath2});
  //==============================================================================
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'tcase': tcase,
      "title": title,
      "description": description,
      'piriority': piriority,
      "eventDate": eventDate,
      "time": time,
      'places': columnPlaces,
      'path1': columnPath1,
      'path2': columnPath2
    };
  }
}
//==============================================================================
