
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({super.key, required this.mainTitle, required this.mainSubtitle});
final String mainTitle,mainSubtitle;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeInUp(
              duration: Duration(milliseconds: 1300),
              child: Text(
                mainTitle,
                style: TextStyle(color: Colors.white, fontSize: 40),
              )),
          SizedBox(
            height: 10,
          ),
          FadeInUp(
            duration: Duration(milliseconds: 1300),
            child: Text(
              mainSubtitle,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );

  }
}
