import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffA42B2A),
      ),
      backgroundColor: Color(0xffA42B2A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xffba0020),
                border: Border.all(
                  color: Color(0xffba0020),
                  width: 5.0
                )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),

              child:  Image(
                  image: AssetImage('assets/images/programing.png'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height*0.3,

                )
              ),
            ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: AnimatedTextKit(
                 repeatForever: true,

                 animatedTexts:[
                TypewriterAnimatedText('This Application is Developed by Generation Z from the Fedral Union of Myanmar.',
                  textStyle: TextStyle(
                    fontFamily: 'Mina',
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center
                )

             ]),
           ),

          ],
        ),
      ),
    );
  }
}
