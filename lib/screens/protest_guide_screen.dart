import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/screens/first_aid_screen.dart';
import 'package:nway_oo_revolution/screens/safety_during_protest_screen.dart';
import 'package:nway_oo_revolution/screens/way_to_fight_back_screen.dart';


class ProtestGuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).protect_guide),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstAidScreen()));
              },
              child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 7,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Icons.add,
                      //   color: Colors.white,
                      //   size: MediaQuery.of(context).size.width*0.2,),
                      Text(Languages.of(context).first_aid,style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),),

                    ],
                  ),

                ),
              ),
            ),
          ),
          Expanded(child: TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SafetyDuringProtestScreen()));
              },
              child: ProtestItem(Languages.of(context).safety_during_protest))),
          Expanded(child: TextButton( onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WayToFightBackScreen()));
          },child: ProtestItem(Languages.of(context).way_to_fight_back))),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.2,
            ),
          )
        ],
      ),
    );
  }

}

class ProtestItem extends StatelessWidget {
  final String title;
  ProtestItem(this.title);
  @override
  Widget build(BuildContext context) {

     return  Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
            borderRadius: BorderRadius.circular(20.0),
            border:Border.all(width: 0.10, color: Colors.grey[300]) ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: AssetImage('assets/images/nway_oo_revolution_icon.png'),
                width: 120.0,
                height: 120.0,
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
                      title,
                      style: TextStyle(
                          color: Color(0xffA42B2A),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}