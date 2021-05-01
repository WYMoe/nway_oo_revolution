import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/models/news_model.dart';
import 'package:photo_view/photo_view.dart';

class SafetyDuringProtestViewerScreen extends StatefulWidget {
  final String title;
  final String detail;
  final List<dynamic> photo;
  SafetyDuringProtestViewerScreen(this.title,this.photo,this.detail);
  @override
  _SafetyDuringProtestViewerScreenState createState() => _SafetyDuringProtestViewerScreenState(

      title: title,
      photo:photo,

      detail: detail
  );
}

class _SafetyDuringProtestViewerScreenState extends State<SafetyDuringProtestViewerScreen> {


  final String detail;

  final String title;

  List<dynamic> photo = [];
  _SafetyDuringProtestViewerScreenState({this.detail,this.photo,this.title});
  String convertNewLine(String content) {

    return content.replaceAll(r'\n', '\n');
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> imgList = [];
    for(int i =0;i<photo.length;i++){
      imgList.add(SafetyImage(photo[i]));
    }
    return Scaffold(
      appBar:  AppBar(
          title: Text(title),
          backgroundColor: Color(0xffA42B2A),
        ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Column(
            children: imgList,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              convertNewLine(detail),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),

            ),
          ),
        ],
      )

    );
  }
}


class SafetyImage extends StatelessWidget {
 final  String photo;
  SafetyImage(this.photo);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: PhotoView(
            imageProvider: NetworkImage(
              photo,

            ),
              backgroundDecoration: BoxDecoration(color: Colors.white),




              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 1.8,
              initialScale: PhotoViewComputedScale.contained,
              basePosition: Alignment.center,

          ),
        ),
        SizedBox(height: 10.0,)
      ],
    );
  }
}
