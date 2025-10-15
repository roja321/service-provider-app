import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_project/Binding/customer_binding.dart';
import 'package:interview_project/View/customer_screen.dart';
import '../Controller/customer_bottom_app_bar_controller.dart';

class CustomerBottomAppBar extends StatelessWidget {
  final CustomerBottomController controller = Get.put(CustomerBottomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to EasyService Customer page"),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                controller.showLogoutDialog(context);
              },
              child:  CircleAvatar(
                backgroundColor: Colors.teal[50],
                child: Icon(Icons.logout, color: Colors.teal),
              ),
            ),
          ),
        ],),

      body: Navigator(
        key: Get.nestedKey(1),
        onGenerateRoute: (settings) {
          print("settings.name--${settings.name}");
          switch (settings.name) {
            case '/customer':
              return GetPageRoute(
                page: () => CustomerScreen(),
                binding: CustomerScreenBinding(),
              );
            // case '/customer':
            //   return GetPageRoute(
            //     page: () => CustomerScreen(),
            //     binding: CustomerScreenBinding(),
            //   );

            default:
              return GetPageRoute(
                page: () => CustomerScreen(),
                binding: CustomerScreenBinding(),
              );
          }
        },
      ),


      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomNavItem(Icons.home, 0),
            // bottomNavItem(Icons.search, 1),
  ]
        ),
      ),
    );
  }

  Widget bottomNavItem(IconData icon, int index) {
    return Obx(() => IconButton(
      icon: Icon(icon,
          color: controller.selectedIndex.value == index
              ? Colors.teal[100]
              : Colors.grey),
      onPressed: () {
        controller.changeIndex(index);
      },
    ));
  }
}