import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {


  final String city;
  final String date;
  final Timestamp dateTime;
  final String detail;
  final String time;
  final String title;
  final String township;
 var photo = [];

  NewsModel({this.city,this.date,this.dateTime,this.detail,this.photo,this.title,this.time,this.township});

  factory NewsModel.fromDocument(doc){
    return NewsModel(
      city: doc['city'],
      date: doc['date'],

      dateTime: doc['datetime'],
      detail: doc['detail'],
      photo: doc['photo'],
      title: doc['title'],
      time: doc['time'],
      township: doc['township']

    );

  }


}