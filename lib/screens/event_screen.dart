import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nway_oo_revolution/models/first_aid_model.dart';
import 'package:nway_oo_revolution/models/news_model.dart';
import 'package:nway_oo_revolution/screens/first_aid_viewer_screen.dart';
import 'package:nway_oo_revolution/screens/event_viewer_screen.dart';
import 'package:nway_oo_revolution/screens/news_viewer_screen.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("event")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<FirstAidTile> firstAidList = [];
                  snapshot.data.docs.forEach((doc) {
                   Timestamp datetime=doc['datetime'];
                   String detail = doc['detail'];
                     String photo = doc['photo'];
                     String title = doc['title'];
                     String id = doc['id'];


                    firstAidList.add(FirstAidTile(photo: photo,detail: detail,title: title,datetime: datetime,id: id,));
                  });

                  return ListView(
                    children: firstAidList,
                    physics: BouncingScrollPhysics(),
                  );
                },
              ))
        ],
      ),
    );
  }
}



class FirstAidTile extends StatelessWidget {

  FirstAidTile({this.photo,this.detail,this.title,this.datetime,this.id});
  final Timestamp datetime;
  final String detail;
  final String photo;
  final String title;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventViewerScreen(title: title,id: id,) ));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              child: Card(
                elevation: 5.0,
                shadowColor: Colors.white38,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                           photo,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'see more ...',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
