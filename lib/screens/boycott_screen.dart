import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/models/cdm_help_model.dart';
import 'package:nway_oo_revolution/screens/boycott_category_screen.dart';
import 'package:nway_oo_revolution/screens/cdm_help_viewer_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class BoycottScreen extends StatefulWidget {


  @override
  _BoycottScreenState createState() => _BoycottScreenState();
}

class _BoycottScreenState extends State<BoycottScreen> {
  ScrollController controller = ScrollController();
  double topContainer = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('boycott').doc('data').collection('category').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<BoycottTile> boycottList = [];
          snapshot.data.docs.forEach((doc) {
            String id = doc['id'];
            String name = doc['name'];
            String number = doc['number'];
            String photo = doc['photo'];

            //  print('name:' + cdmHelpModel.name);
            boycottList.add(BoycottTile(id,name,number,photo));
          });

          return Scaffold(
              appBar: AppBar(
                title: Text(Languages.of(context).boycott),
                backgroundColor: Color(0xffA42B2A),
              ),
              body:Container(
                height: size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: boycottList.length,
                          controller: controller,
                          itemBuilder: (context,index){
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
                                transform:  Matrix4.identity()..scale(scale,scale),
                                alignment: Alignment.bottomCenter,
                                child: Align(
                                    heightFactor: 0.7,
                                    alignment: Alignment.topCenter,
                                    child: boycottList[index]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
          );
        });
  }
}

class BoycottTile extends StatelessWidget {
  final String id;
  final String name;
  final String number;
  final String photo;
  BoycottTile(this.id,this.name,this.number,this.photo);
  @override
  Widget build(BuildContext context) {
    // List<NetworkImage> networkImage = [];
    // newsModel.photo.forEach((element) {
    //   networkImage.add(
    //     NetworkImage(element.toString())
    //   );
    //
    // });
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return BoycottCategoryScreen(name);
        }));
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
                image: NetworkImage(photo),
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
                      style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,color: Color(0xffA42B2A) ),
                      //  overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(number,
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
