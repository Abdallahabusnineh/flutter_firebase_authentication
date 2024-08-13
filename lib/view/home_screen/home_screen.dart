import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/controller/auth_controller/auth_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: GetBuilder<AuthController>(
            init: AuthController(),
            builder: (controller) {
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
