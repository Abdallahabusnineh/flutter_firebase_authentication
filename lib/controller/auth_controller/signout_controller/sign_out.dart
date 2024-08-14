import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../view/auth_ui/login/login_screen.dart';

class SignOutController extends GetxController {
  signOut() async {
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginContent());
    update();
  }
}