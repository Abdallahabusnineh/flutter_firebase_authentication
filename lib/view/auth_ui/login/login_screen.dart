import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/regex_validation.dart';
import '../register/register_screen.dart';
import '../widget/auth_ui.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthUi(
      uiIsLogin: true,
      mainTitle: 'Login',
      mainSubtitle: 'Welcome back!',
      emailHintText: 'email',
      passwordHintText: 'password',
    ));
  }
}
