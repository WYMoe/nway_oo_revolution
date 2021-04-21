import 'package:cloud_firestore/cloud_firestore.dart';

class FirstAidModel {


  final String id;


  final String title;
  var  photo = [];
  final String detail;

  FirstAidModel({this.id,this.title,this.photo,this.detail});

  factory FirstAidModel.fromDocument(doc){
    return FirstAidModel(
        id: doc['id'],

        detail: doc['detail'],
        photo: doc['photo'],

        title: doc['title']

    );

  }


}