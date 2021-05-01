import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nway_oo_revolution/models/news_model.dart';
import 'package:nway_oo_revolution/screens/news_viewer_screen.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("news")
              .orderBy("datetime", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<NewsTile> newsList = [];
            snapshot.data.docs.forEach((doc) {
              NewsModel newsModel = NewsModel.fromDocument(doc);
              newsList.add(NewsTile(newsModel));
            });

            return ListView(
              children: newsList,
              physics: BouncingScrollPhysics(),
            );
          },
        ))
      ],
    );
  }
}

// class NewsItem extends StatelessWidget {
//   final NewsModel newsModel;
//   NewsItem(this.newsModel);
//   @override
//   Widget build(BuildContext context) {
//
//     // List<NetworkImage> networkImage = [];
//     // newsModel.photo.forEach((element) {
//     //   networkImage.add(
//     //     NetworkImage(element.toString())
//     //   );
//     //
//     // });
//     return  Container(
//         margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15.0),
//             border:Border.all(width: 0.1, color: Colors.grey[300]) ),
//         child: Row(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15.0),
//               child: Image(
//                 image: NetworkImage(newsModel.photo[0]),
//                 width: 120.0,
//                 height: 120.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.all(10.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       newsModel.date,
//                       style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w600),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 4.0),
//
//                     Text(newsModel.detail,
//                         style:  TextStyle(
//                             fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
//                     SizedBox(height: 4.0),
//                     TextButton(
//                      child: Text('see more ...',style: TextStyle(
//                          fontSize: 16.0,
//                          fontWeight: FontWeight.w600,
//                          color: Colors.blueAccent),),
//                       onPressed: (){
//                        print(' hello ');
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => NewsViewerScreen()),
//                        );
//                       },
//
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//   }
// }

class NewsTile extends StatelessWidget {
  final NewsModel newsModel;
  NewsTile(this.newsModel);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                      builder: (context) => NewsViewerScreen(newsModel)));
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
                          newsModel.photo[0],
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: 12,
                    ),  Text(
                      newsModel.time,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      newsModel.date,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      newsModel.city,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      newsModel.title,
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
