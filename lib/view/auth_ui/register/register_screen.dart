import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../login/login_screen.dart';
import '../widget/auth_ui.dart';

class RegisterContent extends StatelessWidget {
  const RegisterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthUi(
      uiIsLogin: false,
      mainTitle: 'Register',
      mainSubtitle: 'Create new account',
      emailHintText: 'email',
      passwordHintText: 'password',
    ));
  }
}
