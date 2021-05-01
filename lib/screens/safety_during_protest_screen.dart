import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/screens/safety_during_protest_viewer_screen.dart';

class SafetyDuringProtestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).safety_during_protest),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("safetyduringprotest")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<SafetyDuringProtestTile> safetyList = [];
                  snapshot.data.docs.forEach((doc) {
                    String title = doc['title'];
                    List<dynamic> photo = doc['photo'];
                    String detail = doc['detail'];
                    safetyList.add(SafetyDuringProtestTile(photo,title,detail));
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



class SafetyDuringProtestTile extends StatelessWidget {
 final List<dynamic> photo;
 final String title;
 final String detail;
  SafetyDuringProtestTile(this.photo,this.title,this.detail);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 13),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(6),
                bottomLeft: Radius.circular(6)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(18.0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SafetyDuringProtestViewerScreen(title, photo, detail)));
            },
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
        ));
  }
}
