import 'package:flutter/material.dart';

class SocialPunishmentViewerScreen extends StatelessWidget {
  final String photo;
  final String name;
  final String detail;
  final String id;
  final String type;
  SocialPunishmentViewerScreen(this.photo, this.name, this.detail, this.id, this.type);
  String convertNewLine(String content) {

    return content.replaceAll(r'\n', '\n');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Social Punishment'),
        backgroundColor: Color(0xffA42B2A),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [

              ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(18),topLeft: Radius.circular(18)),
                  child: Image.network(
                    photo,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
              height: 12,
            ),
              Text(
              name,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                 convertNewLine(detail),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )],
          ),
        ),
      ),
    );
  }
}
