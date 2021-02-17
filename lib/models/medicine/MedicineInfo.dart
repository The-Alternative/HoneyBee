class MedicineInfo {
  int medId;
  String medTitle;
  String medform;
  int diagonid;
  String personName;
  String img_direct;
  int diagid ;
  String first_date ;//daydate
  String first_clock ;
  String daydate ;//daydate
  String day_time ;//daytime
  String doctname ;
  int patId ;
  String diagon ;
  String notice ;
  String last_date ;
  int timesId;
  String amount;
  int dayesId;int day_time_state;int sortn;

  MedicineInfo(
      {this.medId,
        this.medTitle,
        this.medform, this.diagonid,this.personName,this.img_direct,
        this.first_date,this.last_date,this.first_clock
        ,this.notice,this.diagon,this.patId,this.diagid,this.doctname,this.dayesId,this.timesId,this.sortn,this.day_time_state
        ,this.daydate,this.day_time,this.amount});

  factory MedicineInfo.fromMap(Map<String, dynamic> json) => MedicineInfo(
    medId: json["id"],
    medTitle: json["title"],
    medform: json["form"],
    diagonid:json["d_id"],
    personName:json["p_name"],
    img_direct:json["img_direct"],
    diagid: json["d_id"],
    doctname: json["d_name"]
    ,diagon: json["diagon"] ,
    first_clock:  json["fclock"]
    ,first_date:  json["fdate"],
    last_date: json["ldate"]
    ,notice: json["notic"] ,
    patId: json["p_id"] ,
    amount : json['amount'],
    timesId :json['tmid'],
    dayesId :json['dayid'],
    daydate :json['d_date'],
    day_time_state :json['d_t_state'],
    day_time :json['d_time'],
    sortn : json["sortn"],
  );
  MedicineInfo medicineMapToObject(Map<String, dynamic> json) => MedicineInfo(
    medId: json["id"],
    medTitle: json["title"],
    medform: json["form"],
    diagonid:json["d_id"],
    personName:json["p_name"],
    img_direct:json["img_direct"],
    diagid: json["d_id"],
    doctname: json["d_name"]
    ,diagon: json["diagon"] ,
    first_clock:  json["fclock"]
    ,first_date:  json["fdate"],
    last_date: json["ldate"]
    ,notice: json["notic"] ,
    patId: json["p_id"] ,
    amount : json['amount'],
    timesId :json['tmid'],
    dayesId :json['dayid'],
    daydate :json['d_date'],
    day_time :json['d_time'],
    sortn : json["sortn"],

  );
  Map<String, dynamic> toMap() => {
    "title": medTitle,
    "form": medform,
    "d_id":diagonid,
    "p_name":personName,
    "img_direct":img_direct,
    "d_name": doctname,
    "diagon" :diagon,
    "fclock" :first_clock,
    "fdate" :first_date,
    "ldate" :last_date,
    "notic" :notice,
    "p_id" :patId,
    'amount' :amount,

  };
}
