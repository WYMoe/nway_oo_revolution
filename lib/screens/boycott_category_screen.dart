import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/screens/boycott_product_viewer_screen.dart';


class BoycottCategoryScreen extends StatefulWidget {
  final String typeName;
  BoycottCategoryScreen(this.typeName);
  @override
  _BoycottCategoryScreenState createState() => _BoycottCategoryScreenState();
}

class _BoycottCategoryScreenState extends State<BoycottCategoryScreen> {
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
        stream: FirebaseFirestore.instance
            .collection('boycott')
            .doc('data')
            .collection('boycottproduct')
            .where('type',isEqualTo:widget.typeName )
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(''),
                  backgroundColor: Color(0xffA42B2A),
                ),
                body: Center(child: CircularProgressIndicator()));
          }
          List<BoycottItem> cdmHelpList = [];
          snapshot.data.docs.forEach((doc) {
            String id = doc['id'];
            String name = doc['name'];
            String type = doc['type'];
            String photo = doc['photo'];
            String detail = doc['detail'];

            //  print('name:' + cdmHelpModel.name);
            cdmHelpList.add(BoycottItem(id, name, type, photo, detail));
          });

          return Scaffold(
              appBar: AppBar(
                title: Text(widget.typeName),
                backgroundColor: Color(0xffA42B2A),
              ),
              body: Container(
                height: size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: cdmHelpList.length,
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
                                    child: cdmHelpList[index]),
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

class BoycottItem extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final String photo;
  final String detail;
  BoycottItem(this.id, this.name, this.type, this.photo, this.detail);
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
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return BoycottProductViewerScreen(
            id: id,
            type: type,
            detail: detail,
            name: name,
            photo: photo,
          );
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
                image:photo==''?AssetImage('assets/images/nway_oo_revolution_icon.png'): NetworkImage(photo),
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
