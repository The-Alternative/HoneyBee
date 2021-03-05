class ChildHabit {
  int isActive;
  int habitId;
  int childId;
  String createdDate;
  int id;

  ChildHabit( this.isActive, this.habitId,this.childId, this.createdDate);

  ChildHabit.map(dynamic obj){
    this.isActive = obj['isActive'];
    this.habitId = obj['habitId'];
    this.childId = obj['childId'];
    this.createdDate = obj['createdDate'];
    this.id = obj['id'];

  }


  int get _isActive => isActive;
  int get _habitId => habitId;
  int get _childId => childId;
  String get _createdDate => createdDate;
  int get _id => id;

  Map<String , dynamic> toMap(){
    var map =new Map<String,dynamic>();
    map['isActive'] = _isActive;
    map['habitId'] = _habitId;
    map['childId'] = _childId;
    map['createdDate'] = _createdDate;
    if(id != null){
      map['id'] = _id;
    }
    return map;
  }

  ChildHabit.fromeMap(Map<String,dynamic>map){
    this.isActive = map['isActive'];
    this.habitId = map['habitId'];
    this.childId = map['childId'];
    this.createdDate = map['createdDate'];
    this.id = map['id'];
  }
}