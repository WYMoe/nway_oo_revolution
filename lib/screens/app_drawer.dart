import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/localization/language/languages.dart';
import 'package:nway_oo_revolution/localization/locale_constant.dart';
class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int selectedVal = 0;

  setVal(int i) {
    setState(() {
      selectedVal = i;
    });
    Navigator.pop(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    // if(Languages.of(context).languageName=='English'){
    //   selectedVal = 1;
    // }else if( Languages.of(context).languageName=='မြန်မာ'){
    //   selectedVal = 2;
    // }else if( Languages.of(context).languageName=='中文'){
    //   selectedVal = 3;
    //
    // }
    super.initState();
  }

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
                            'assets/images/nway_oo_revolution_icon.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          Languages.of(context).nway_oo_revolution,
                          style:
                              TextStyle(fontSize: 14.0, color: Color(0xffA42B2A)),
                        ),
                      ),
                    ),
                  ],
                )),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: <Widget>[
                        RadioListTile(
                          title: Text('English'),
                            value: 1,
                            groupValue: selectedVal,
                            onChanged: (val) {
                              changeLanguage(context, 'en');
                              setVal(val);
                            }),
                        RadioListTile(
                            title:Text('မြန်မာ'),
                            value: 2,
                            groupValue: selectedVal,
                            onChanged: (val) {
                              changeLanguage(context, 'my');
                              setVal(val);

                            }),
                        RadioListTile(
                          title: Text('中文'),
                            value: 3,
                            groupValue: selectedVal,
                            onChanged: (val) {
                            changeLanguage(context, 'zh');
                              setVal(val);

                            }),
                      ],
                    );
                  },
                );
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Color(0xffA42B2A),
                  ),
                  title: Text(Languages.of(context).languageName),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.sms_rounded, color: Color(0xffA42B2A)),
                  title: Text(Languages.of(context).contact_us_or_make_suggestion),
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
                  leading: Icon(Icons.info, color: Color(0xffA42B2A)),
                  title: Text(Languages.of(context).about_us),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
