import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/core/utils/regex_validation.dart';
import 'package:flutter_firebase_authentication/view/auth_ui/widget/top_container.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controller/auth_controller/auth_controller.dart';
import '../login/login_screen.dart';
import '../register/register_screen.dart';

class AuthUi extends StatelessWidget {
  const AuthUi(
      {super.key,
      required this.uiIsLogin,
      required this.mainTitle,
      required this.mainSubtitle,
      required this.emailHintText,
      required this.passwordHintText});

  final bool uiIsLogin;
  final String mainTitle, mainSubtitle, emailHintText, passwordHintText;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (AuthController controller) {
        return Form(
          key: uiIsLogin ? controller.loginFormKey : controller.registerFormKey,
          child: Container(
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
                TopContainer(mainTitle: mainTitle, mainSubtitle: mainSubtitle),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    const BoxShadow(
                                        color: Colors.blueGrey,
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: FadeInUp(
                                      duration: Duration(milliseconds: 1000),
                                      child: TextFormField(
                                        controller: uiIsLogin
                                            ? controller.emailControllerLogin
                                            : controller
                                                .emailControllerRegister,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: emailHintText,
                                            prefixIcon: Icon(Icons.person),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter email ';
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  uiIsLogin
                                      ? SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: FadeInUp(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            child: TextFormField(
                                              controller: controller
                                                  .usernameControllerRegister,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                  hintText: 'Name',
                                                  prefixIcon:
                                                      Icon(Icons.person),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please Enter username';
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: FadeInUp(
                                      duration: Duration(milliseconds: 1000),
                                      child: TextFormField(
                                        obscureText: uiIsLogin
                                            ? controller.loginShowPassword
                                            : controller.registerShowPassword,
                                        controller: uiIsLogin
                                            ? controller.passwordControllerLogin
                                            : controller
                                                .passwordControllerRegister,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                            hintText: passwordHintText,
                                            prefixIcon: Icon(Icons.security),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  uiIsLogin
                                                      ? controller
                                                          .loginShowPasswordToggle()
                                                      : controller
                                                          .registerShowPasswordToggle();
                                                },
                                                icon: uiIsLogin
                                                    ? controller
                                                            .loginShowPassword
                                                        ? Icon(Icons
                                                            .remove_red_eye)
                                                        : Icon(Icons
                                                            .remove_red_eye_outlined)
                                                    : controller
                                                            .registerShowPassword
                                                        ? Icon(Icons
                                                            .remove_red_eye)
                                                        : Icon(Icons
                                                            .remove_red_eye_outlined)),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'password is too short';
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            uiIsLogin
                                ? TextButton(
                                    onPressed: () {
                                      if (controller.emailControllerLogin.text == "") {
                                        print('enter email');
                                      }
                                      else {
                                        controller.forgotPassword();
                                      }
                                    },
                                    child: FadeInUp(
                                      duration: Duration(milliseconds: 1000),
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue.shade900),
                                child: Center(
                                    child: FadeInUp(
                                  duration: Duration(milliseconds: 1000),
                                  child: TextButton(
                                    onPressed: () {
                                      uiIsLogin
                                          ? controller.loginProcessValidate()
                                          : controller
                                              .registerProcessValidate();
                                    },
                                    child: Text(
                                      uiIsLogin ? 'LOGIN' : 'REGISTER NOW',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))),
                            SizedBox(
                              height: 10,
                            ),
                            FadeInUp(
                                duration: Duration(milliseconds: 1000),
                                child: uiIsLogin
                                    ? Text('Don\'t have an account ?')
                                    : Text('Already have an account?')),
                            FadeInUp(
                                duration: Duration(milliseconds: 1000),
                                child: TextButton(
                                    onPressed: () {
                                      uiIsLogin
                                          ? Get.off(RegisterContent())
                                          : Get.off(LoginContent());
                                    },
                                    child: uiIsLogin
                                        ? Text(
                                            'SIGN UP',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        : Text(
                                            'SIGN IN',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
