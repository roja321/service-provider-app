import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/auth_service.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();


  @override
  void onInit() {
    _checkIfLoggedIn();
    super.onInit();
  }
  void _checkIfLoggedIn() async {
    String? role = await _authService.checkCurrentUser();
    if (role != null) {
      if (role == 'Service Provider') {
        Get.offAllNamed('/serviceproviderbottomappbar');
      } else if (role == 'Customer') {
        Get.offAllNamed('/customerbottomappbar');
      }
    }
  }

  void logout() async {
    await _authService.signOut();
    Get.offAllNamed('/login');
  }
  void login() async {
    try {
      String? result = await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );
      print("resulit--${result}");
      Navigator.of(Get.context!, rootNavigator: true).pop();
      if (result == 'Service Provider') {
        Get.offNamed('/serviceproviderbottomappbar');
      } else if (result == 'Customer') {
        Get.offNamed('/customerbottomappbar');
      } else {
        Get.snackbar("Errorr", "Please register your profile",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }catch(e){
      print("error aaya---${e}");
    }
  }


  final nameController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  String selectedRole = 'Customer'; // Default selected role for dropdown

  bool isPasswordHidden = true;

  // Signup function to handle user registration
  void signup() async {
    try{

      // Call signup method from AuthService with user inputs
      String? result = await _authService.signup(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        role: selectedRole,
      );

print("resulit--${result}");
      Navigator.of(Get.context!, rootNavigator: true).pop();
      if (result == null) {
        // Signup successful: Navigate to LoginScreen with success message
        Get.snackbar("Successful",  "Profile registered successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
       Get.offNamed('/login');
      } else {
        Get.snackbar("Error", "Authentication failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }}catch(e){
      print("inside catch--${e}");
    }
  }


}