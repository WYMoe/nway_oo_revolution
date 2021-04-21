import 'package:flutter/material.dart';

class BoycottProductViewerScreen extends StatelessWidget {
  final String photo;
  final String name;
  final String detail;
  final String id;
  final String type;
  BoycottProductViewerScreen({this.photo, this.name, this.detail, this.id, this.type});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(name),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [

              ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(18),topLeft: Radius.circular(18)),
                  child: Image.network(
                    photo,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 12,
              ),
              Text(
                name,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 8,
              ), Text(
               'Type : '+ type,
                maxLines: 2,
                style: TextStyle(
                  color: Color(0xffA42B2A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  this.detail,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )],
          ),
        ),
      ),
    );
  }
}
