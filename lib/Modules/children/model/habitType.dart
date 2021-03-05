class HabitType {
  String name;
  int id;

  HabitType(this.name);

  HabitType.map(dynamic obj){
    this.name = obj['name'];
    this.id = obj['id'];

  }

  String get _name => name;
  int get _id => id;

  Map<String , dynamic> toMap(){
    var map =new Map<String,dynamic>();
    map['name'] = _name;
    if(id != null){
      map['id'] = _id;
    }
    return map;
  }

  HabitType.fromeMap(Map<String,dynamic>map){
    this.name = map['name'];
    this.id = map['id'];
  }
}