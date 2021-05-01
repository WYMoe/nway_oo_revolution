import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nway_oo_revolution/screens/event_viewer_screen.dart';
import 'package:nway_oo_revolution/screens/knowledge_viewer_screen.dart';
class KnowledgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("knowledge")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<KnowledgeTile> knowledgeList = [];
                snapshot.data.docs.forEach((doc) {
                  Timestamp datetime=doc['datetime'];
                  String photo = doc['photo'];
                  String title = doc['title'];
                  String id = doc['id'];


                  knowledgeList.add(KnowledgeTile(photo: photo,title: title,datetime: datetime,id: id,));
                });

                return ListView(
                  children: knowledgeList,
                  physics: BouncingScrollPhysics(),
                );
              },
            ))
      ],
    );
  }
}
class KnowledgeTile extends StatelessWidget {

  KnowledgeTile({this.photo,this.title,this.datetime,this.id});
  final Timestamp datetime;

  final String photo;
  final String title;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: InkWell(
              borderRadius: BorderRadius.circular(18.0),

              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KnowledgeViewerScreen(title: title,id: id,) ));
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
          ),
        ));
  }
}
