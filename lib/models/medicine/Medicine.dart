class Medicine {
  int _medId;
  String _medTitle;
  String _medform;
  Medicine();
  Medicine.WithId(this._medTitle, this._medform, [this._medId]);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_medId != null) {
      map['id'] = _medId;
    }
    map['title'] = _medTitle;
    map['form'] = _medform;

    return map;
  }

  // Extract a Patint object from a Map object
  Medicine.fromMapObject(Map<String, dynamic> map) {
    this._medId = map['id'];
    this._medTitle = map['title'];
    this._medform = map['form'];
  }
  int get medId => _medId;
  set medId(int value) {
    _medId = value;
  }

  String get medTitle => _medTitle;

  set medTitle(String value) {
    _medTitle = value;
  }

  String get medform => _medform;

  set medform(String value) {
    _medform = value;
  }
}
