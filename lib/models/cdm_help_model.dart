import 'package:cloud_firestore/cloud_firestore.dart';

class CDMHelpModel {


  final String id;
  final String name;

  final String phone;
  final String photo;
  final String facebooklink;
  final String detail;

  CDMHelpModel({this.id,this.name,this.phone,this.photo,this.facebooklink,this.detail});

  factory CDMHelpModel.fromDocument(doc){
    return CDMHelpModel(
     id: doc['id'],
      name: doc['name'],
      detail: doc['detail'],
      photo: doc['photo'],
      facebooklink: doc['facebooklink'],
      phone: doc['phone']

    );

  }


}