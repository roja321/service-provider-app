// This screen handles user login with email and password
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:interview_project/View/signup_screen.dart';
import '../Controller/auth_controller.dart';
import '../Service/auth_service.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Input for email
              TextField(
                controller: authController.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                    suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Input for password
              TextField(
                controller: authController.passwordController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.no_encryption_outlined),
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                ),

                // Hide password
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle( backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),),
                  onPressed: authController.login, // Call login function
                  child: const Text('Login', style: TextStyle(color: Colors.white),),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                     Get.offNamed('/signup');
                    },
                    child: const Text(
                      "Signup here",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

