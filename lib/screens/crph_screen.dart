import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nway_oo_revolution/screens/crph_viewer_screen.dart';
import 'package:nway_oo_revolution/screens/safety_during_protest_viewer_screen.dart';

class CRPHScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRPH Movement'),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("CRPHmovement")
                .orderBy("datetime",descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<CRPHTile> safetyList = [];
              snapshot.data.docs.forEach((doc) {
                String title = doc['title'];
                List<dynamic> photo = doc['photo'];
                String detail = doc['detail'];
                String date = doc['date'];
                Timestamp datetime = doc['datetime'];
                String provelink = doc['provelink'];
                String time = doc['time'];

                safetyList.add(CRPHTile(
                  title: title,
                  datetime: datetime,
                  detail: detail,
                  date: date,
                  time: time,
                  photo: photo,
                  provelink: provelink,
                ));
              });

              return ListView(
                children: safetyList,
                physics: BouncingScrollPhysics(),
              );
            },
          ))
        ],
      ),
    );
  }
}

class CRPHTile extends StatelessWidget {
  final List<dynamic> photo;
  final String title;
  final String detail;
  final String date;
  final Timestamp datetime;
  final String provelink;
  final String time;
  CRPHTile(
      {this.photo,
      this.title,
      this.detail,
      this.datetime,
      this.date,
      this.time,
      this.provelink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CRPHViewerScreen(
                      provelink: provelink,
                      time: time,
                      date: date,
                      detail: detail,
                      dateTime: datetime,
                      title: title,
                      photo: photo,
                    )));
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
                            photo[0],
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        height: 12,
                      ), Text(
                        date+"  "+time,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),    SizedBox(
                        height: 8.0,
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
