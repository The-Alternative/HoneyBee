class MedicineTimes {
  int _timesId;
  int _dayesId;
  int _digonId;
  String _dayTime;
  int _medicineState;

  MedicineTimes(this._dayesId, this._dayTime, this._medicineState,this._digonId,
      [this._timesId]);
  MedicineTimes.WithId();

  int get digonId => _digonId;

  set digonId(int value) {
    _digonId = value;
  }

  String get dayTime => _dayTime;

  set dayTime(String value) {
    _dayTime = value;
  }

  int get dayesId => _dayesId;

  int get timesId => _timesId;

  set timesId(int value) {
    _timesId = value;
  }

  set dayesId(int value) {
    _dayesId = value;
  }
  int get medicineState => _medicineState;

  set medicineState(int value) {
    _medicineState = value;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_timesId != null) {
      map['tid'] = _timesId;
    }
    map['d_id'] = _digonId;
    map['day_id'] = _dayesId;
    map['d_time'] = _dayTime;
    map['d_t_state'] = _medicineState;
    return map;
  }



  // Extract a Times object from a Map object
  MedicineTimes.fromMapObject(Map<String, dynamic> map) {
    this._timesId = map['tid'];
    this._dayesId = map['day_id'];
    this._digonId = map['d_id'];
    this._dayTime = map['d_time'];
    this._medicineState = map['d_t_state'];
  }
}
