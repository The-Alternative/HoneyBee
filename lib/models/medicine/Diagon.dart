class Diagon {
  int _diagonId;
  int _patId;
  String _doctName;
  String _medAmount;
  String _diagon;
  String _instruction;
  String _dayes;
  String _firstDate;
  String _firstClock;
  String _times;
  String _img_direct;
  String _notice;
  String get notice => _notice;
  set notice(String value) {
    _notice = value;
  }

  int _medId;
  String get firstDate => _firstDate;

  set firstDate(String value) {
    _firstDate = value;
  }

  Diagon.withId(
      this._patId,
      this._doctName,
      this._medAmount,
      this._diagon,
      this._instruction,
      this._firstDate,
      this._firstClock,
      this._dayes,
      this._times,
      this._img_direct,
      this._medId,
      this._notice,
      [this._diagonId]);
  Diagon();
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_diagonId != null) {
      map['diagonId'] = _diagonId;
    }
    map['d_id'] = _diagonId;
    map['p_id'] = _patId;
    map['d_name'] = _doctName;
    map['amount'] = _medAmount;
    map['diagon'] = _diagon;
    map['description'] = _instruction;
    map["fdate"] = _firstDate;
    map["fclock"] = _firstClock;
    map['dayes'] = _dayes;
    map['times'] = _times;
    map['img_direct'] = _img_direct;
    map['notic'] = _notice;
    map['id'] = _medId;
    return map;
  }

  // Extract a Diagon object from a Map object
  Diagon.fromMapObject(Map<String, dynamic> map) {
    this._diagonId = map['d_id'];
    this._patId = map['p_id'];
    this._doctName = map['d_name'];
    this._medAmount = map['amount'];
    this._diagon = map['diagon'];
    this._instruction = map['description'];
    this._firstDate = map['fdate'];
    this.firstClock = map['fclock'];
    this._dayes = map['dayes'];
    this._times = map['times'];
    this._img_direct = map['img_direct'];
    this._notice = map['notic'];
    this._medId = map['id'];
  }

  int get diagonId => _diagonId;

  set diagonId(int value) {
    _diagonId = value;
  }

  int get patId => _patId;

  set patId(int value) {
    _patId = value;
  }

  String get doctName => _doctName;

  set doctName(String value) {
    _doctName = value;
  }

  String get medAmount => _medAmount;

  set medAmount(String value) {
    _medAmount = value;
  }

  String get diagon => _diagon;

  set diagon(String value) {
    _diagon = value;
  }

  String get instruction => _instruction;

  set instruction(String value) {
    _instruction = value;
  }

  String get dayes => _dayes;

  set dayes(String value) {
    _dayes = value;
  }

  String get times => _times;

  set times(String value) {
    _times = value;
  }

  String get img_direct => _img_direct;

  set img_direct(String value) {
    _img_direct = value;
  }

  int get medId => _medId;

  set medId(int value) {
    _medId = value;
  }

  String get firstClock => _firstClock;

  set firstClock(String value) {
    _firstClock = value;
  }
}