import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(
                            'assets/images/nway_oo_revolution_icon.png'
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'Nway Oo Revolution',
                        style:
                            TextStyle(fontSize: 18.0, color: Color(0xffA42B2A)),
                      ),
                    ),
                  ],
                )),
            InkWell(
              onTap: () {
                //
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (context){
                //       return Home();
                //     }
                // ));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.language,
                    color:  Color(0xffA42B2A),

                  ),
                  title: Text('Change Language'),

                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (context){
                //       return WeatherScreen();
                //     }
                // ));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.sms_rounded, color: Color(0xffA42B2A)),
                  title: Text('Contact'),
                ),
              ),
            ), InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (context){
                //       return WeatherScreen();
                //     }
                // ));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.info, color:  Color(0xffA42B2A)),
                  title: Text('About Us'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
