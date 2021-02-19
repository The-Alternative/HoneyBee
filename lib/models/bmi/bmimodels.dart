import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiModel {

  double result;
  bool isNormal;
  String comment;
  double res;
  double reso;
  String length;
  String wight;
  Color color;
  int index;

  BmiModel({this.result,this.isNormal,this.comment,this.res,this.reso,this.length,this.wight,this.index,this.color});
}

class CardInfo {

  String length;
  String wight;
  String datt;
  String bmi;
  String comment;
  int id;
  int index;


  CardInfo({this.length,this.wight,this.datt,this.bmi,this.id,this.comment,this.index});

  factory CardInfo.fromMap(Map<String, dynamic> json) => CardInfo(
    id: json["id"],
    bmi: json["bmi"],
    length:json["height"],
    wight:json["weight"],
    datt:json["date"],
    comment: json["comment"],
    index: json["colorindex"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "bmi": bmi,
    "height": length,
    "weight":wight,
    "date":datt,
    "comment":comment,
    "colorindex": index,
  };
}