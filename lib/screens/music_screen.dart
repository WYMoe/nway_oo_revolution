import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/models/cdm_help_model.dart';
import 'package:nway_oo_revolution/screens/boycott_category_screen.dart';
import 'package:nway_oo_revolution/screens/cdm_help_viewer_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  ScrollController controller = ScrollController();
  double topContainer = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('music').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xffA42B2A),
                ),
                body: Center(child: CircularProgressIndicator()));
          }
          List<MusicTile> musicList = [];
          int i =0;
          snapshot.data.docs.forEach((doc) {
            String composed = doc['composed'];
            //String id = doc['id'];
            String link = doc['link'];
            String name = doc['name'];
            String photo = doc['photo'];
            String singer = doc['singer'];


          //print(name);

            musicList.add(MusicTile(
              // id: id,
              photo: photo,
              name: name,
              composed: composed,
              link: link,
              singer: singer,
            ));
          });

          return Scaffold(
              appBar: AppBar(
                title: Text(Languages.of(context).music_playlist),
                backgroundColor: Color(0xffA42B2A),
              ),
              body: Container(
                height: size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: musicList.length,
                          controller: controller,
                          itemBuilder: (context, index) {
                            double scale = 1.0;

                            if (topContainer > 0.5) {
                              scale = index + 0.5 - topContainer;
                              if (scale < 0) {
                                scale = 0;
                              } else if (scale > 1) {
                                scale = 1;
                              }
                            }
                            return Opacity(
                              opacity: scale,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..scale(scale, scale),
                                alignment: Alignment.bottomCenter,
                                child: Align(
                                    heightFactor: 0.7,
                                    alignment: Alignment.topCenter,
                                    child: musicList[index]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ));
        });
  }
}

class MusicTile extends StatelessWidget {
  final String composed;
  final String id;
  final String link;
  final String name;
  final String photo;
  final String singer;
  MusicTile(
      {this.composed, this.id, this.link, this.name, this.photo, this.singer});

  _launchURL(String linkUrl) async {
    String url = 'https://www.youtube.com/watch?v=' + linkUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return BoycottCategoryScreen(name);
        // }));
       _launchURL(link);
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 0.9, color: Colors.brown)),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: AssetImage('assets/images/youtube.png'),
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffA42B2A)),
                      //  overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text('Sing by $singer',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4.0),
                    Text('Composed by $composed',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
