import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroScreen extends StatefulWidget {
  @override
  _HeroScreenState createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  int _currentIndex = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  double count = 0.0;
  double min = 0.0;
  double max = 0.0;
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('hero').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Hero'),
                backgroundColor: Color(0xffA42B2A),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          List<Item> cardList = [];
          snapshot.data.docs.forEach((doc) {
            cardList.add(Item(
              name: doc['name'],
              age: doc['age'],
              url: doc['photo'],
            ));
            max = cardList.length.toDouble();
          });
          return Scaffold(
            appBar: AppBar(
              title: Text('Hero'),
              backgroundColor: Color(0xffA42B2A),
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: Colors.red[700],
                      inactiveTrackColor: Colors.red[100],
                      trackShape: RoundedRectSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbShape:
                      RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: Colors.redAccent,
                      overlayColor: Colors.red.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 18.0),
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.red[700],
                      inactiveTickMarkColor: Colors.red[100],
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.redAccent,
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Slider(
                      divisions: cardList.length,
                      value: count,

                      min: min,
                      max: max,
                      onChanged: (val) {
                        setState(() {
                          count = val;
                        });
                        buttonCarouselController.jumpToPage(count.toInt());
                      },
                    ),
                  ),   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total - ${cardList.length}',
                        style: TextStyle(
                            color:  Color(0xffA42B2A),
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                    child: CarouselSlider(
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          height: 500.0,
                          // autoPlay: true,
                          // autoPlayInterval: Duration(seconds: 3),
                          // autoPlayAnimationDuration:
                          //     Duration(milliseconds: 800),
                          // autoPlayCurve: Curves.fastOutSlowIn,
                          // pauseAutoPlayOnTouch: true,

                          //aspectRatio: 4/3,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,

                          scrollPhysics: BouncingScrollPhysics(),

                          initialPage: count.toInt(),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: cardList.map((card) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                child: card);
                          });
                        }).toList()),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class Item extends StatelessWidget {
  final String url;
  final String age;
  final String name;
  Item({this.url, this.name, this.age});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: url == ""||url==null
                  ? Image.asset(
                      'assets/images/nway_oo_revolution_icon.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.5,
                    )
                  : Image.network(
                      this.url,
                      // height:  MediaQuery.of(context).size.height*0.23,
                      // width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height * 0.5,


                    )),
          Text(name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          Text(age,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
