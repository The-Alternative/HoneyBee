class Medicine_Date{
  int _day,_month,_year;

  Medicine_Date(this._day, this._month, this._year);

  get year => _year;

  set year(value) {
    _year = value;
  }

  get month => _month;

  set month(value) {
    _month = value;
  }

  int get day => _day;

  set day(int value) {
    _day = value;
  }


}
