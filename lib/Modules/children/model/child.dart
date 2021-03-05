class Child {
  String name;
  String sex;
  String birthDate;
  String image;
  int isActive;
  int id;

  Child(this.name, this.sex, this.birthDate, this.image, this.isActive);

  Child.map(dynamic obj){
    this.name = obj['name'];
    this.sex = obj['sex'];
    this.birthDate = obj['birthDate'];
    this.image = obj['image'];
    this.isActive = obj['isActive'];
    this.id = obj['id'];

  }

  String get _name => name;
  String get _sex => sex;
  String get _birthDate => birthDate;
  String get _image => image;
  int get _isActive => isActive;
  int get _id => id;

  Map<String , dynamic> toMap(){
    var map =new Map<String,dynamic>();
    map['name'] = _name;
    map['sex'] = _sex;
    map['birthDate'] = _birthDate;
    map['image'] = _image;
    map['isActive'] = _isActive;
    if(id != null){
      map['id'] = _id;
    }
    return map;
  }

  Child.fromeMap(Map<String,dynamic>map){
    this.name = map['name'];
    this.sex = map['sex'];
    this.birthDate = map['birthDate'];
    this.image = map['image'];
    this.isActive = map['isActive'];
    this.id = map['id'];
  }
}