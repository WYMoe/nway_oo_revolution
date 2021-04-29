import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/screens/boycott_screen.dart';
import 'package:nway_oo_revolution/screens/cdm_help_screen.dart';
import 'package:nway_oo_revolution/screens/music_screen.dart';
import 'package:nway_oo_revolution/screens/protest_guide_screen.dart';
import 'package:nway_oo_revolution/screens/social_punishment_screen.dart';

class RevolutionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MainButton(
                    mainButtonName: Languages.of(context).cdm_helps,
                    route: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CDMHelpScreen();
                      }));
                    },
                    image: 'cdm_help_ic',
                  ),
                ),
                Expanded(
                  child: MainButton(
                    mainButtonName: Languages.of(context).protect_guide,
                    route: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProtestGuideScreen();
                      }));
                    },
                    image: 'protest_guide_ic',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MainButton(
                    mainButtonName: Languages.of(context).social_punishment,
                    route: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SocialPunishmentScreen();
                      }));
                    },
                    image: 'social_punishment_ic',
                  ),
                ),
                Expanded(
                  child: MainButton(
                    mainButtonName: Languages.of(context).boycott,
                    route: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BoycottScreen();
                      }));
                    },
                    image: 'boycott_ic',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MusicScreen();
                  }));
                },
                child: Card(
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),

                  // color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/music_ic.png',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              Languages.of(context).music_playlist,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                 // color: Color(0xff1f456e),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          )
        ],
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final String mainButtonName;
  final Function route;

  final String image;

  MainButton({this.mainButtonName, this.route, this.image});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: route,
      child: Card(
        margin:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),

        // color: Colors.lightBlueAccent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  'assets/images/${image}.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.142,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    mainButtonName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        //color: Color(0xff1f456e),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
