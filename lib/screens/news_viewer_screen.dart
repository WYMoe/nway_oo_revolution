import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/models/news_model.dart';
import 'package:nway_oo_revolution/screens/photo_view_screen.dart';

class NewsViewerScreen extends StatefulWidget {
  final NewsModel newsModel;
  NewsViewerScreen(this.newsModel);
  @override
  _NewsViewerScreenState createState() => _NewsViewerScreenState(
    township: newsModel.township,
    time: newsModel.time,
    title: newsModel.title,
    photo: newsModel.photo,
    dateTime: newsModel.dateTime,
    city: newsModel.city,
    date: newsModel.date,
    detail: newsModel.detail
  );
}

class _NewsViewerScreenState extends State<NewsViewerScreen> {

  final String city;
  final String date;
  final Timestamp dateTime;
  final String detail;
  final String time;
  final String title;
  final String township;
  List<dynamic> photo = [];
  _NewsViewerScreenState({this.city,this.date,this.dateTime,this.detail,this.photo,this.title,this.time,this.township});

  int _currentIndex=0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  String convertNewLine(String content) {

    return content.replaceAll(r'\n', '\n');
  }
  @override
  Widget build(BuildContext context) {
    List cardList=[

    ];
    for(int i =0; i<photo.length;i++){
      cardList.add(
        Item(photo[i],photo)
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).nway_oo_revolution),
        backgroundColor: Color(0xffA42B2A),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: CarouselSlider(
                  options: CarouselOptions(
                    //height: 300.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: cardList.map((card){
                    return Builder(
                        builder:(BuildContext context){
                          return Padding(
                            padding: const EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return PhotoViewScreen(photo[_currentIndex ]);
                                }));
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.6,
                                width: MediaQuery.of(context).size.width,
                                child: card
                              ),
                            ),
                          );
                        }
                    );
                  }).toList(),            ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(cardList, (index, url) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index ? Color(0xffAB381F) : Colors.grey,
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                this.title,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,),
              textAlign: TextAlign.center,
              ),
              Column(

                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    this.date+'  '+this.time,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,),SizedBox(
                    height: 8,
                  ),Text(
                    this.city,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,),SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                     convertNewLine(this.detail),

                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          ),
                      textAlign: TextAlign.justify,
                      ),
                  ),
                ],
              )
            ],

          ),
        )
    );
  }
}

class Item extends StatelessWidget {
  final String url;
  final List<dynamic> photo;
  Item(this.url,this.photo);
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       stops: [0.3, 1],
      //       colors: [Color(0xffff4000),Color(0xffffcc66),]
      //   ),
      // ),


      child: SingleChildScrollView(
        child: Stack(
        //  mainAxisAlignment: MainAxisAlignment.center,
          alignment: Alignment.topRight,

          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  this.url,
                  height:  MediaQuery.of(context).size.height*0.23,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(topRight: Radius.circular(18))


              ),
              child: Text('Tap to View',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            )

          ],
        ),
      ),
    );
  }
}
