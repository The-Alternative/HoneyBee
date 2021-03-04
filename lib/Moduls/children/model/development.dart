class Development {
  String name;
  String note;
  int tall;
  int weight;
  int tempreture;
  int isActive;
  int childId;
  String createdDate;
  int id;

  Development(this.name, this.note, this.tall, this.weight, this.tempreture, this.isActive, this.childId, this.createdDate);

  Development.map(dynamic obj){
    this.name = obj['name'];
    this.note = obj['note'];
    this.tall = obj['tall'];
    this.weight = obj['weight'];
    this.tempreture = obj['tempreture'];
    this.isActive = obj['isActive'];
    this.childId = obj['childId'];
    this.createdDate = obj['createdDate'];
    this.id = obj['id'];

  }

  String get _name => name;
  String get _note => note;
  int get _tall => tall;
  int get _weight => weight;
  int get _tempreture => tempreture;
  int get _isActive => isActive;
  int get _childId => childId;
  String get _createdDate => createdDate;
  int get _id => id;

  Map<String , dynamic> toMap(){
    var map =new Map<String,dynamic>();
    map['name'] = _name;
    map['note'] = _note;
    map['tall'] = _tall;
    map['weight'] = _weight;
    map['tempreture'] = _tempreture;
    map['isActive'] = _isActive;
    map['childId'] = _childId;
    map['createdDate'] = _createdDate;
    if(id != null){
      map['id'] = _id;
    }
    return map;
  }

  Development.fromeMap(Map<String,dynamic>map){
    this.name = map['name'];
    this.note = map['note'];
    this.tall = map['tall'];
    this.weight = map['weight'];
    this.tempreture = map['tempreture'];
    this.isActive = map['isActive'];
    this.childId = map['childId'];
    this.createdDate = map['createdDate'];
    this.id = map['id'];
  }
}