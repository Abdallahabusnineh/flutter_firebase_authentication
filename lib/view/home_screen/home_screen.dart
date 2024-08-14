import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/controller/auth_controller/signout_controller/sign_out.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: GetBuilder<SignOutController>(
            init: SignOutController(),
            builder: (SignOutController controller) {
              return ElevatedButton(onPressed: (){
                controller.signOut();
              }, child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              );
        
            },
          ),
        ),
      ),
    );
  }
}
