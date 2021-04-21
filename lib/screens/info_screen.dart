import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/screens/boycott_screen.dart';
import 'package:nway_oo_revolution/screens/cdm_help_screen.dart';
import 'package:nway_oo_revolution/screens/crph_screen.dart';
import 'package:nway_oo_revolution/screens/event_screen.dart';
import 'package:nway_oo_revolution/screens/hero_screen.dart';
import 'package:nway_oo_revolution/screens/music_screen.dart';
import 'package:nway_oo_revolution/screens/protest_guide_screen.dart';
import 'package:nway_oo_revolution/screens/social_punishment_screen.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: MainButton(
                  mainButtonName: 'Event',
                  route: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EventScreen();
                    }));
                  },
                  image: 'mawkon_event',
                ),
              ),
              Expanded(
                child: MainButton(
                  mainButtonName: 'Event',
                  route: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HeroScreen();
                    }));
                  },
                  image: 'mawkon_hero',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black38),
                color: Colors.white),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CRPHScreen();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/crph.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
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
      onTap: route,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/${image}.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.142,
            ),
          ),
        ),
      ),
    );
  }
}
