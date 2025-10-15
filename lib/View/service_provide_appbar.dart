import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_project/Binding/customer_binding.dart';
import 'package:interview_project/Binding/service_provider_binding.dart';
import 'package:interview_project/Binding/service_provider_home_binding.dart';
import 'package:interview_project/Controller/service_provide_appbar_controller.dart';
import 'package:interview_project/View/customer_screen.dart';
import 'package:interview_project/View/service_provide_home_screen.dart';
import 'package:interview_project/View/service_provider_screen.dart';
import '../Controller/customer_bottom_app_bar_controller.dart';

class ServiceProviderBottomAppBar extends StatelessWidget {
  final ServiceProviderBottomAppBarController controller = Get.put(ServiceProviderBottomAppBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to EasyService Service Provider"),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                controller.showLogoutDialog(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.logout, color: Colors.grey),
              ),
            ),
          ),
        ],),

      body: Navigator(
        key: Get.nestedKey(1),
        onGenerateRoute: (settings) {
          print("settings.name--${settings.name}");
          switch (settings.name) {
            case '/serviceprovider':
              return GetPageRoute(
                page: () => ServiceProviderScreen(),
                binding: ServiceProviderScreenBinding(),
              );
            case '/serviceproviderhomepg':
              return GetPageRoute(
                page: () => ServiceProviderHomeScreen(),
                binding: ServiceProviderHomeScreenBinding(),
              );

            default:
              return GetPageRoute(
                page: () => ServiceProviderScreen(),
                binding: ServiceProviderScreenBinding(),
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
            bottomNavItem(Icons.home, 1),
            bottomNavItem(Icons.book_online_sharp, 0),
          ],
        ),
      ),
    );
  }

  Widget bottomNavItem(IconData icon, int index) {
    return Obx(() => IconButton(
      icon: Icon(icon,
          color: controller.selectedIndex.value == index
              ? Colors.blue
              : Colors.grey),
      onPressed: () {
        controller.changeIndex(index);
      },
    ));
  }
}