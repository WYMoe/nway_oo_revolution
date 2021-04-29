import 'package:audioplayers/audio_cache.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/icon/bottom_navigation_icon.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/screens/about_us_screen.dart';
import 'package:nway_oo_revolution/screens/app_drawer.dart';
import 'package:nway_oo_revolution/screens/info_screen.dart';
import 'package:nway_oo_revolution/screens/knowledge_screen.dart';
import 'package:nway_oo_revolution/screens/news_screen.dart';
import 'package:nway_oo_revolution/screens/revolution_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/localization_delegate.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Nway Oo Revolution',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: _locale,
      home: MyHomePage(),
      supportedLocales: [
        Locale('en', ''),
        Locale('my', ''),
        Locale('zh', '')
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode &&
              supportedLocale?.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
    );

  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int pageIndex = 0;
  int tabIndex = 0;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache;
  String filePath = 'sound.mp3';




    @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();
    super.initState();

    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
  }

  /// Compulsory
  playMusic() async {
    await audioCache.play('sound.mp3');
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
           _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.list,
              color: Colors.grey,
              size: 30.0,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () async{
                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                  //   return null;
                  // }));
                  audioPlayerState == AudioPlayerState.PLAYING
                      ? pauseMusic()
                      : playMusic();
                },
                icon: Icon(
                  audioPlayerState == AudioPlayerState.PLAYING?  Icons.music_note:Icons.music_off_rounded,
                  color: Colors.grey,
                )),
            IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                  //   return null;
                  // }));
                  print(' hi');
                },
                icon: Icon(
                  Icons.notifications,
                  color: Colors.grey,
                ))
          ],
        ),
        body: PageView(
          children: [
            NewsScreen(),
            RevolutionScreen(),
            InfoScreen(),
            KnowledgeScreen()
          ],
          controller: pageController,
          onPageChanged: (pageIndex) {
            setState(() {
              this.pageIndex = pageIndex;
            });
          },
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: [
            Icon(
              BottomNavigationIcon.news,
              color: Colors.white,

            ),
            Icon(BottomNavigationIcon.revolution, color: Colors.white),
            Icon(BottomNavigationIcon.mawkon, color: Colors.white),
            Icon(BottomNavigationIcon.knowledge, color: Colors.white),
          ],
          // activeColor: Theme.of(context).primaryColor,

          backgroundColor: Colors.white12,
          index: pageIndex,
          onTap: (tabIndex) {
            pageController.jumpToPage(tabIndex);
          },
          color: Color(0xffA42B2A),
          buttonBackgroundColor: Color(0xffAB381F),
          height: 60.0,
          animationDuration: Duration(milliseconds:300),
        ));
  }
}
