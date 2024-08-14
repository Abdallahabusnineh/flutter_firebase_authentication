import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/utils/regex_validation.dart';
import '../../../core/utils/show_toast.dart';
import '../../../view/auth_ui/verified_email_address/verified_email_screen.dart';

class RegisterController extends GetxController {
  TextEditingController usernameControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController emailControllerRegister = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool registerShowPassword=false;

  registerProcessValidate() async {
        if(registerFormKey.currentState!.validate()){
          try {
            final credential = await FirebaseAuth
                .instance
                .createUserWithEmailAndPassword(
                email:
                emailControllerRegister.text,
                password:
                passwordControllerRegister
                    .text
            );
            showToast(text: 'Account created successfully!', state: ToastState.SUCCESS);
            FirebaseAuth.instance.currentUser!.sendEmailVerification();
            Get.offAll(const VerifiedEmailScreen());
          } on FirebaseAuthException catch (e) {
            switch (e.message) {
              case 'email-already-in-use':
                return showToast(text: 'The account already exists for that email.', state: ToastState.ERROR);
              case 'weak-password':
                return showToast(text: 'The password provided is too weak.', state: ToastState.ERROR);
              case 'invalid-email':
                return showToast(text: 'The email address is badly formatted.', state: ToastState.ERROR);
              case 'operation-not-allowed':
                return showToast(text: 'Email/password accounts are not enabled.', state: ToastState.ERROR);
              case 'user-disabled':
                return showToast(text: 'The user account has been disabled.', state: ToastState.ERROR);
              default:
                return showToast(text: 'An undefined Error happened, try again.', state: ToastState.ERROR);
            }
          }
        }
      update();
  }

  bool validateEmailRegisterController(){
    if(validateEmailRegex(email: emailControllerRegister.text)){
      return true;
    }else{
      return false;
    }
  }
  bool validatePasswordRegisterController(){
    if(validatePasswordRegex(password: passwordControllerRegister.text)){
      return true;
    }else{
      return false;
    }
  }

  registerShowPasswordToggle(){
    registerShowPassword=!registerShowPassword;
    update();
  }


}
