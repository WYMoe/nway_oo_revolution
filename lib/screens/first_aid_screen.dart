import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/models/first_aid_model.dart';
import 'package:nway_oo_revolution/models/news_model.dart';
import 'package:nway_oo_revolution/screens/first_aid_viewer_screen.dart';
import 'package:nway_oo_revolution/screens/news_viewer_screen.dart';

class FirstAidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).first_aid),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("firstaid")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<FirstAidTile> firstAidList = [];
                  snapshot.data.docs.forEach((doc) {
                    FirstAidModel firstAidModel = FirstAidModel.fromDocument(doc);
                    firstAidList.add(FirstAidTile(firstAidModel));
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
  final FirstAidModel firstAidModel;
  FirstAidTile(this.firstAidModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FirstAidViewerScreen(firstAidModel)));
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
                            firstAidModel.photo[0],
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        firstAidModel.title,
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
