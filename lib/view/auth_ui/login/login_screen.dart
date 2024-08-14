import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/controller/auth_controller/login_controller/login_controller.dart';
import 'package:flutter_firebase_authentication/view/home_screen/home_screen.dart';
import 'package:get/get.dart';

import '../../../core/utils/regex_validation.dart';
import '../register/register_screen.dart';
import '../widget/top_container.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (LoginController controller) {
              return Form(
                key: controller.loginFormKey,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      gradient:
                      LinearGradient(begin: Alignment.topCenter, colors: [
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
                      TopContainer(
                          mainTitle: 'Login',
                          mainSubtitle: 'Welcome back!'),
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
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: FadeInUp(
                                            duration:
                                            Duration(milliseconds: 1000),
                                            child: TextFormField(
                                              controller: controller.emailControllerLogin,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                  hintText: 'Email',
                                                  prefixIcon:
                                                  Icon(Icons.person),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter email ';
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
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: FadeInUp(
                                            duration:
                                            Duration(milliseconds: 1000),
                                            child: TextFormField(
                                              obscureText: controller
                                                  .loginShowPassword,
                                              controller: controller
                                                  .passwordControllerLogin,
                                              keyboardType:
                                              TextInputType.visiblePassword,
                                              decoration: InputDecoration(
                                                  hintText: 'Password',
                                                  prefixIcon:
                                                  Icon(Icons.security),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      controller.loginShowPasswordToggle();
                                                    },
                                                    icon: Icon(controller
                                                        .loginShowPassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
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
                                    height: 40,
                                  ),
                                  TextButton(onPressed: (){
                                    controller.forgotPassword();
                                  }, child: Text('Forgot Password?',style: TextStyle(color: Colors.grey),)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          color: Colors.blue.shade900),
                                      child: Center(
                                          child: FadeInUp(
                                            duration: Duration(milliseconds: 1000),
                                            child: TextButton(
                                              onPressed: () {
                                                controller.loginProcessValidate();
                                              },
                                              child: Text(
                                                'LOGIN',
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
                                      child: Text('Don\'t have an account?')),
                                  FadeInUp(
                                      duration: Duration(milliseconds: 1000),
                                      child: TextButton(
                                          onPressed: () {
                                            Get.off(RegisterContent());
                                          },
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
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
            }));
  }
}
