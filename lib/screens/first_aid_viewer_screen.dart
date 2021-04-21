import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/models/first_aid_model.dart';

class FirstAidViewerScreen extends StatelessWidget {
  final FirstAidModel firstAidModel;
  FirstAidViewerScreen(this.firstAidModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(firstAidModel.title),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("firstaid")
                .doc(firstAidModel.id)
                .collection("detail")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<FirstAidViewerTile> firstAidViewerList = [];
              snapshot.data.docs.forEach((DocumentSnapshot doc) {
                String detail = doc['detail'];
                String photo = doc['photo'];
                String title = '';

                if (doc.data().containsKey('title')) {
                  title = doc['title'];
                }

                firstAidViewerList.add(FirstAidViewerTile(photo, title, detail));
              });

              return ListView(
                children: firstAidViewerList,
                physics: BouncingScrollPhysics(),
              );
            },
          ))
        ],
      ),
    );
  }
}

class FirstAidViewerTile extends StatelessWidget {
  String photo;
  String title;
  String detail;
  FirstAidViewerTile(this.photo, this.title, this.detail);
  String convertNewLine(String content) {

    return content.replaceAll(r'\n', '\n');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title == ''
            ? SizedBox(
                height: 5.0,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
        Image(
          image: NetworkImage(photo),
          fit: BoxFit.fitHeight,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            convertNewLine(detail),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
