class Card_info {
  int _diagId,_timesId,_dayesId,_day_time_state,_sortn;
  String _img_direct;
  String get img_direct => _img_direct;

  set img_direct(String value) {
    _img_direct = value;
  }

  get sortn => _sortn;

  set sortn(value) {
    _sortn = value;
  }

  get timesId => _timesId;

  set timesId(value) {
    _timesId = value;
  }

  int get diagId => _diagId;

  set diagId(int value) {
    _diagId = value;
  }
  String _person_name,_day_time;

  get day_time => _day_time;

  set day_time(value) {
    _day_time = value;
  }

  String _medicine,_dayDate;

  get dayDate => _dayDate;

  set dayDate(value) {
    _dayDate = value;
  }

  String _amount;
  Card_info(this._person_name, this._medicine, this._amount,this._timesId,this._dayesId,this._day_time,this._day_time_state,
      this._sortn,this._dayDate,this._img_direct, [this._diagId]);
  Card_info.WithId();

  String get amount => _amount;

  set amount(String value) {
    _amount = value;
  }

  String get medicine => _medicine;

  set medicine(String value) {
    _medicine = value;
  }

  String get person_name => _person_name;

  set person_name(String value) {
    _person_name = value;
  }

  Card_info.fromMapObject(Map<String, dynamic> map) {
    this._person_name = map['p_name'];
    this._medicine = map['title'];
    this._amount = map['amount'];
    this.timesId =map['tmid'];
    this._dayesId =map['dayid'];
    this.day_time =map['d_time'];
    this.day_time_state =map['d_t_state'];
    this._diagId = map["dgid"];
    this._dayDate =map['d_date'];
    this._sortn = map["sortn"];
    this.img_direct =map["img_direct"];

  }

  get dayesId => _dayesId;

  set dayesId(value) {
    _dayesId = value;
  }

  get day_time_state => _day_time_state;

  set day_time_state(value) {
    _day_time_state = value;
  }
}
