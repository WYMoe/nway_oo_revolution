import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/screens/social_punishment_viewer_screen.dart';

class SocialPunishmentScreen extends StatefulWidget {
  @override
  _SocialPunishmentScreenState createState() => _SocialPunishmentScreenState();
}

class _SocialPunishmentScreenState extends State<SocialPunishmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _val = 'All';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('socialpunishment')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<SocialPunishmentTile> safetyList = [];
          snapshot.data.docs.forEach((doc) {
            String title = doc['name'];
            String photo = doc['photo'];
            String detail = doc['detail'];
            String id = doc['id'];
            String type = doc['type'];
            if (_val == 'All') {
              safetyList
                  .add(SocialPunishmentTile(photo, title, detail, id, type));
            } else if (_val ==type) {
              safetyList
                  .add(SocialPunishmentTile(photo, title, detail, id, type));
            }
          });


          return Scaffold(
            appBar: AppBar(
              title: Text('Social Punishment'),
              backgroundColor: Color(0xffA42B2A),
            ),
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Color(0xffA42B2A), width: 3.0)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        //dropdownColor: Theme.of(context).primaryColor,

                        elevation: 1,
                        isDense: false,
                        value: _val,

                        items: [
                          DropdownMenuItem(
                            child: Text("All"),
                            value: 'All',
                          ),
                          DropdownMenuItem(
                            child: Text("Artists"),
                            value: 'Artists',
                          ),
                          DropdownMenuItem(
                              child: Text("Junta Related"),
                              value: "Junta Related"),
                          DropdownMenuItem(
                              child: Text("Junta Supporters"),
                              value: "Junta Supporters"),
                          DropdownMenuItem(
                            child: Text("Military Coup"),
                            value: "Military Coup",
                          ),
                          DropdownMenuItem(
                            child: Text("Social Influencers"),
                            value: "Social Influencers",
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _val = val;
                            print(_val);
                          });
                        }),
                  ),
                ),
                Column(
                  children: safetyList,
                )
              ],
            ),
          );
        });
  }
}

class SocialPunishmentTile extends StatelessWidget {
  final String photo;
  final String name;
  final String detail;
  final String id;
  final String type;
  SocialPunishmentTile(this.photo, this.name, this.detail, this.id, this.type);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SocialPunishmentViewerScreen( photo, name,detail, id,type,)));
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        name,
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
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