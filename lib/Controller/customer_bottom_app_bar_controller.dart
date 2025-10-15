import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class CustomerBottomController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
    Get.offNamed(pageRoutes[index], id: 1);
  }

  static final List<String> pageRoutes = [
    '/customer',
    '/search',
  ];

  void showLogoutDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        FirebaseAuth.instance.signOut();
        Get.back(); // Close the dialog
        Get.find<AuthController>().logout();
        // Get.offAllNamed('/login');
        Get.snackbar("Logged Out", "You have successfully logged out.");
      },
    );
  }
}
