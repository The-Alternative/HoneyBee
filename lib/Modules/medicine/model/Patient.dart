class Patient {
  int _patId;
  String _patName;

  Patient(this._patName, [this._patId]);
  Patient.Without();
  String get patName => _patName;

  set patName(String value) {
    _patName = value;
  }

  int get patId => _patId;

  set patId(int value) {
    _patId = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_patId != null) {
      map['p_id'] = _patId;
    }
    map['p_name'] = _patName;

    return map;
  }
  Patient patientMapToObject(Map<String, dynamic> json) => Patient(
      json["p_name"],json["p_id"]
  );
  // Extract a Patint object from a Map object
  Patient.fromMapObject(Map<String, dynamic> map) {
    this._patId = map['p_id'];
    this._patName = map['p_name'];
  }
}
