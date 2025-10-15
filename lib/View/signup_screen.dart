import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/auth_controller.dart';
import '../Service/auth_service.dart';
import '../widget/custome_widget.dart';
import 'login_screen.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: authController.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                suffixIcon: Icon(Icons.man_2),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
                labelText: 'Password',
                suffixIcon: Icon(Icons.no_encryption_outlined),
                border: const OutlineInputBorder(),

              ),
            ),

            const SizedBox(height: 16),
            // Dropdown for selecting role
            DropdownButtonFormField<String>(
              value: authController.selectedRole,
              decoration: const InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                authController.selectedRole =
                newValue!; // Update role selection
              },
              items: ['Service Provider', 'Customer'].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Button stretches across width
              child: ElevatedButton(
                style: ButtonStyle( backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),),
                onPressed: () {
                  CustomWidgets.showLoader(context);
                  authController.signup();
                },
                child: const Text('Signup',style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Get.offNamed('/login');
                  },
                  child: const Text(
                    "Login here",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: -1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}