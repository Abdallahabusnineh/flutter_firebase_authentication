import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/view/auth_ui/login/login_screen.dart';
import 'package:flutter_firebase_authentication/view/home_screen/home_screen.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('**************************User is currently signed out!**************************');
    } else {
      print('**************************User is signed in!**************************');
    }
  });

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:(FirebaseAuth.instance.currentUser!=null && FirebaseAuth.instance.currentUser!.emailVerified)?HomeScreen():LoginContent()
    );
  }

}

