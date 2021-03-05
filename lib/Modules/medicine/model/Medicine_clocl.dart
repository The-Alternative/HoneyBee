class Medicine_clocl{
  int _dayDate;
  String _clock;
  Medicine_clocl(this._dayDate,this._clock);

  int get dayDate => _dayDate;

  set dayDate(int value) {
    _dayDate = value;
  }

  get clock => _clock;

  set clock(value) {
    _clock = value;
  }}