import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkhead/Controller/authBinding.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Controller/userController.dart';
import 'package:linkhead/Screens/HomeScreen.dart';
import 'package:linkhead/Screens/editProfileScreen.dart';
import 'package:linkhead/Screens/signinScreen.dart';
import 'package:linkhead/Screens/signupScreen.dart';

import 'Utils/Root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  // Get.put(UserController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      theme: ThemeData(),
      home: Root(),
      getPages: [
        GetPage(name: '/', page: () => Root()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/editprofile', page: () => EditProfileScreen()),
        GetPage(name: '/signin', page: () => SigninScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}

// Global Variables


