import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/controller/auth_controller/register_controller/register_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../login/login_screen.dart';
import '../widget/top_container.dart';

class RegisterContent extends StatelessWidget {
  const RegisterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RegisterController>(
            init: RegisterController(),
            builder: (RegisterController controller) {
              return Form(
                key: controller.registerFormKey,
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
                          mainTitle: 'Register',
                          mainSubtitle: 'Create Account Now!'),
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
                                              controller: controller
                                                  .emailControllerRegister,
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
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: FadeInUp(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            child: TextFormField(
                                              obscureText: controller
                                                  .registerShowPassword,
                                              controller: controller
                                                  .passwordControllerRegister,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              decoration: InputDecoration(
                                                  hintText: 'Password',
                                                  prefixIcon:
                                                      Icon(Icons.security),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .registerShowPasswordToggle();
                                                    },
                                                    icon: Icon(controller
                                                            .registerShowPassword
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
                                           controller.registerProcessValidate();
                                          },
                                          child: Text(
                                             'REGISTER NOW',
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
                                      child: Text('Already have an account?')),
                                  FadeInUp(
                                      duration: Duration(milliseconds: 1000),
                                      child: TextButton(
                                          onPressed: () {
                                             Get.off(LoginContent());
                                          },
                                          child: Text(
                                                  'SIGN IN',
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
