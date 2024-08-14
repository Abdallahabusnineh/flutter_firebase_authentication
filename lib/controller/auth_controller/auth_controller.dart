import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/core/utils/show_toast.dart';
import 'package:flutter_firebase_authentication/view/home_screen/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../core/utils/regex_validation.dart';
import '../../view/auth_ui/login/login_screen.dart';
import '../../view/auth_ui/verified_email_address/verified_email_screen.dart';


class AuthController extends GetxController {
  TextEditingController emailControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
  TextEditingController usernameControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController emailControllerRegister = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool loginShowPassword=true;
  bool registerShowPassword=true;



  registerProcessValidate() async {
    String errorMessage='';
   if (validatePasswordRegisterController())
     {
       if(validateEmailRegisterController()) {
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
             showToast(text: 'Account created successfully', state: ToastState.SUCCESS);
             FirebaseAuth.instance.currentUser!.sendEmailVerification();
             Get.offAll(const VerifiedEmailScreen());
           } on FirebaseAuthException catch (e) {
             if (e.code == 'weak-password') {
               showToast(text: 'weak password, Password should be at least 6 characters', state: ToastState.ERROR);
             } else if (e.code == 'email-already-in-use') {
               showToast(text: 'email-already-in-use', state: ToastState.ERROR);
             }
           }
         }
       }
       else showToast(text: 'check your email format ex: mohammed@example.com', state: ToastState.ERROR);

       }
      else showToast(text: 'Your password should be at least 6 characters and contain at least one number and one special letter', state: ToastState.ERROR);


    update();
  }
  loginProcessValidate() async {
    String errorMessage='';
    if(validatePasswordLoginController())
        {
      if(validateEmailLoginController())
        {
          if(loginFormKey.currentState!.validate()){
            try {
              final credential = await FirebaseAuth
                  .instance
                  .signInWithEmailAndPassword(
                  email:
                  emailControllerLogin.text,
                  password:
                  passwordControllerLogin
                      .text
              );
              if(credential.user!.emailVerified){
                showToast(text: 'login successfully!', state: ToastState.SUCCESS);
              Get.offAll(HomeScreen());
              }
              if(!credential.user!.emailVerified){
                showToast(text: 'please check your email and verify your email.', state: ToastState.ERROR);
              }

            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                showToast(text: 'No user found for that email.', state: ToastState.ERROR);
              } else if (e.code == 'wrong-password') {
                showToast(text: 'Wrong password provided for that user.', state: ToastState.ERROR);
              }
            }

          }
          else
          {
            showToast(text: 'check your internet connection', state: ToastState.ERROR);
          }
        }

      else
      {
        showToast(text: 'check your email format example: 2lQp8@example.com', state: ToastState.ERROR);
      }
       }
    else
    {
      showToast(text: 'Your Password Must Be At Least 6 Characters and Contain At Least One Number and One Special Letter', state: ToastState.ERROR);
    }
    update();
  }

  signOut() async {
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginContent());
    update();
  }
  forgotPassword() async {
    try{
      if(FirebaseAuth.instance.currentUser!.emailVerified) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailControllerLogin.text);
        showToast(
            text: 'check your email, we sent you a link to reset your password',
            state: ToastState.SUCCESS);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(text: 'No user found for that email.', state: ToastState.ERROR);
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
  bool validateEmailLoginController(){
    if(validateEmailRegex(email: emailControllerLogin.text)){
      return true;
    }else{
      return false;
    }
  }
  bool validatePasswordLoginController(){
    if(validatePasswordRegex(password: passwordControllerLogin.text)){
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
  loginShowPasswordToggle(){
    loginShowPassword=!loginShowPassword;
    update();
  }
  registerShowPasswordToggle(){
    registerShowPassword=!registerShowPassword;
    update();
  }


}