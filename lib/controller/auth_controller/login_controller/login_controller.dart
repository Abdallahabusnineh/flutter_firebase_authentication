import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/utils/regex_validation.dart';
import '../../../core/utils/show_toast.dart';
import '../../../view/home_screen/home_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool loginShowPassword = false;

  loginProcessValidate() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailControllerLogin.text,
                password: passwordControllerLogin.text);
        if (credential.user!.emailVerified) {
          showToast(text: 'login successfully!', state: ToastState.SUCCESS);
          Get.offAll(HomeScreen());
        }
        if (!credential.user!.emailVerified) {
          showToast(
              text: 'please check your email and verify your email.',
              state: ToastState.ERROR);
        }
      } on FirebaseAuthException catch (e) {
        if (e.message == 'user-not-found') {
          showToast(
              text: 'No user found for that email.', state: ToastState.ERROR);
        } else if (e.message == 'wrong-password') {
          showToast(
              text: 'Wrong password provided for that user.',
              state: ToastState.ERROR);
        }
      }
    }

    update();
  }

  bool validateEmailLoginController() {
    if (validateEmailRegex(email: emailControllerLogin.text)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePasswordLoginController() {
    if (validatePasswordRegex(password: passwordControllerLogin.text)) {
      return true;
    } else {
      return false;
    }
  }

  loginShowPasswordToggle() {
    loginShowPassword = !loginShowPassword;
    update();
  }

  forgotPassword() async {
    try {
        final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailControllerLogin.text);
        print('list $list');
      if (list.isNotEmpty) {
          // The email is registered
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailControllerLogin.text);
        showToast(
            text: 'check your email, we sent you a link to reset your password',
            state: ToastState.SUCCESS);
        } else {
        showToast(text: 'No account found with this email.', state: ToastState.ERROR);
        }

    } on FirebaseException catch (e) {
      showToast(text: 'please enter an email', state: ToastState.ERROR);
    }catch(e){
      print('forgot password catch error:$e');
    }
    update();
  }
}
