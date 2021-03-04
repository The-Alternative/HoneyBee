class Media {
  String mediaUrl;
  int itemId;
  int tableId;
  String createdDate;
  int id;

  Media(this.mediaUrl,this.tableId,this.itemId,this.createdDate);


  Media.map(dynamic obj){
    this.mediaUrl = obj['mediaUrl'];
    this.tableId = obj['tableId'];
    this.itemId = obj['itemId'];
    this.createdDate = obj['createdDate'];
    this.id = obj['id'];

  }

  String get _mediaUrl => mediaUrl;
  int get _tableId => tableId;
  int get _itemId => itemId;
  String get _createdDate => createdDate;
  int get _id => id;

  Map<String , dynamic> toMap(){
    var map =new Map<String,dynamic>();
    map['mediaUrl'] = _mediaUrl;
    map['tableId'] = _tableId;
    map['itemId'] = _itemId;
    map['createdDate'] = _createdDate;
    if(id != null){
      map['id'] = _id;
    }
    return map;
  }

  Media.fromeMap(Map<String,dynamic>map){
    this.mediaUrl = map['mediaUrl'];
    this.tableId = map['tableId'];
    this.itemId = map['itemId'];
    this.createdDate = map['createdDate'];
    this.id = map['id'];
  }
}