import 'package:flutter/material.dart';

abstract class Languages {

  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get languageName;

  String get appName;

  String get news;

  String get revolution;

  String get Mawkon;

  String get Knowledge;

  String get hero;

  String get event;

  String get crph_movement;

  String get protect_guide;

  String get cdm_helps;

  String get social_punishment;

  String get boycott;

  String get music_playlist;

  String get first_aid;

  String get safety_during_protest;

  String get way_to_fight_back;

  String get nway_oo_revolution;

  String get about_us;

  String get contact_us_or_make_suggestion;

  String get all;

  String get artists;

  String get junta_related;

  String get junta_supporters;

  String get  military_coup;

  String get social_influencers;
















}