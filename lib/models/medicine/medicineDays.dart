class MedicineDays {
  int _dayesId;
  int _sortn;
  int get sortn => _sortn;
  set sortn(int value) {
    _sortn = value;
  }

  String _dayDate;
  MedicineDays(this._dayDate,this._sortn,[this._dayesId]);
  MedicineDays.WithId();
  int get dayesId => _dayesId;
  set dayesId(int value) {
    _dayesId = value;
  }

  String get dayDate => _dayDate;

  set dayDate(String value) {
    _dayDate = value;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_dayesId != null) {
      map['day_id'] = _dayesId;
    }
    map['sortn'] =_sortn;
    map['d_date'] = _dayDate;;
    return map;
  }



  // Extract a Times object from a Map object
  MedicineDays.fromMapObject(Map<String, dynamic> map) {
    this._dayesId = map['day_id'];
    this._sortn =map['sortn'];
    this._dayDate = map['d_date'];
  }
  MedicineDays fromMapObject(Map<String, dynamic> json) => MedicineDays(
      json["d_date"],json["sortn"],json["day_id"]);

}
