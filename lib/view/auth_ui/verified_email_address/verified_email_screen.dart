import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/view/auth_ui/login/login_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class VerifiedEmailScreen extends StatelessWidget {
  const VerifiedEmailScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
              Colors.blue.shade400,
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                  duration: Duration(milliseconds: 1300),
                  child: Text(
                    'Verified Email Address',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
              SizedBox(
                height: 10,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1300),
                child: Text(
                  'Check your email and verify your account',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: FadeInUp(
                    duration: Duration(milliseconds: 1300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/verified email address.svg',
                          height: MediaQuery.sizeOf(context).height *.4,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                        ElevatedButton(onPressed: (){
                          Get.off(LoginContent());
                        }, child: Text('Go To Login'),style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                        ))

                      ],
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
