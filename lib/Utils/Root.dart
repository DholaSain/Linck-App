import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Screens/HomeScreen.dart';
import 'package:linkhead/Screens/signinScreen.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().userGetter != null)
          ? HomeScreen()
          : SigninScreen();
    });
  }
}
