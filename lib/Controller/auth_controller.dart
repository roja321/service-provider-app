import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/auth_service.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();


  @override
  void onInit() {
    super.onInit();
  }
  void login() async {
    String? result = await _authService.login(
      email: emailController.text,
      password: passwordController.text,
    );
    print("resulit--${result}");
    if (result == 'Service Provider') {
       Get.offNamed('/serviceproviderbottomappbar');

    } else if (result == 'Customer') {
      Get.offNamed('/customerbottomappbar');
    } else {
      Get.snackbar("Error", "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
      if (result == null) {
        // Signup successful: Navigate to LoginScreen with success message
        Get.snackbar("Sucessfull",  "",
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