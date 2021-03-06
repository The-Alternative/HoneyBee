class Diary{
int id;
String address;
String description;
String date;
String image;

Diary({this.id,this.address, this.description, this.date, this.image,});

factory Diary.fromMap(Map<String, dynamic> json) => Diary(
  id:json["id"],
  address:json["address"],
  description:json["description"],
  date:json["date"],
  image:json["image"],
);

Map<String, dynamic> toMap() => {
  "id": id,
  "address": address,
  "description": description,
  "date":date,
  "image":image,
};

}