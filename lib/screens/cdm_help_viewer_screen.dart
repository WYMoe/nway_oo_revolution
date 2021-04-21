import 'package:flutter/material.dart';
import 'package:nway_oo_revolution/models/cdm_help_model.dart';
import 'package:url_launcher/url_launcher.dart';
class CDMHelpViewerScreen extends StatelessWidget {
  final CDMHelpModel cdmHelpModel;
  CDMHelpViewerScreen(this.cdmHelpModel);
  _launchURL(String linkUrl) async {
    String url =  linkUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cdmHelpModel.name),
        backgroundColor:  Color(0xffA42B2A),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                cdmHelpModel.photo
              ),
            fit:BoxFit.cover,
              height: MediaQuery.of(context).size.height*0.5,
              width:MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 10.0,),
                IconButton(icon: Icon(Icons.call), onPressed:(){
                  _launchURL('tel:' +cdmHelpModel.phone);
                }),

                TextButton(onPressed: (){
                  _launchURL(cdmHelpModel.facebooklink);

                }, child: Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  height: MediaQuery.of(context).size.height*0.08,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Center(
                    child: (
                    Text(
                      'Facebook',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    )
                    ),
                  ),
                ))
              ],

            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                cdmHelpModel.detail,

                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
