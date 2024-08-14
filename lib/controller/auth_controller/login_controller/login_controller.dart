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
       showToast(text: 'email or password is wrong', state: ToastState.ERROR);
        }catch (e) {
        showToast(text: 'something went wrong', state: ToastState.ERROR);
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




  /*Future<void> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailControllerLogin.text);

    // Password reset email sent successfully
    print('Password reset email sent successfully');
    showToast(text: 'Password reset email sent!', state: ToastState.SUCCESS);
    } on FirebaseAuthException catch (e) {
    // Handle specific Firebase Authentication errors
    if (e.code == 'user-not-found') {
    print('No user found for that email.');
    showToast(text: 'No user found for that email.', state: ToastState.ERROR);
    } else if (e.code == 'invalid-email') {
    print('The email address is malformed.');
    showToast(text: 'The email address is malformed.', state: ToastState.ERROR);
    } else {
    print('Error sending password reset email: ${e.code}');
    showToast(text: 'Error sending password reset email: ${e.code}', state: ToastState.ERROR);
    }
    } catch (e) {
    // Handle general errors
    print('Error sending password reset email: $e');
    showToast(text: 'Error sending password reset email: $e', state: ToastState.ERROR);
    }
  }*/



  sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailControllerLogin.text);
      print("Password reset email sent!");
      showToast(text: 'Password reset email sent!', state: ToastState.SUCCESS);
    } catch (e) {
      if (e is FirebaseAuthException) {
       showToast(text: '${e.message}, Please enter valid email', state: ToastState.ERROR);
      } else {
        print("An unknown error occurred: $e");
        showToast(text: 'An unknown error occurred. Please try again later.', state: ToastState.ERROR);
      }
    }
  }


checkEmailIsRegisteredInFirebase(String email) async {
 // print('abdallah ${emailControllerLogin.text.trim()}');

  try {
    List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
   print('whyyyyyy ${signInMethods}');
    return signInMethods.isNotEmpty;
  } catch (e) {
     print("Error checking email existence: $e");
    return false;
  }


}
  forgotPassword() async {
    bool emailExists = await checkEmailIsRegisteredInFirebase(emailControllerLogin.text);
//toDo: why it return false always ??????????????????

    print('${emailControllerLogin.text} ${emailExists}');
    if (emailExists) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailControllerLogin.text);
      print("Password reset email sent to $emailControllerLogin.text");
      showToast(text: 'Password reset email sent to $emailControllerLogin.text', state: ToastState.SUCCESS);
    } else {
      showToast(text: 'Please enter a valid email.', state: ToastState.ERROR);
      print("Email does not exist in Firebase.");
    }
    update();
  }
}
