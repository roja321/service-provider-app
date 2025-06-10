import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:interview_project/Binding/cusomer_bottom_app_bar_binding.dart';
import 'package:interview_project/Binding/service_provider_binding.dart';
import 'package:interview_project/Binding/customer_binding.dart';
import 'package:interview_project/Binding/service_provider_home_binding.dart';
import 'package:interview_project/View/customer_bottom_app_bar.dart';
import 'package:interview_project/View/service_provide_appbar.dart';
import 'package:interview_project/View/service_provide_home_screen.dart';
import 'package:interview_project/View/service_provider_screen.dart';
import 'package:interview_project/View/signup_screen.dart';
import 'Binding/auth_binding.dart';
import 'Binding/service_provide_appbar_binding.dart';
import 'View/login_screen.dart';
import 'View/customer_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/serviceprovider',
      page: () => ServiceProviderScreen(),
      binding: ServiceProviderScreenBinding(),
    ),
    GetPage(
      name: '/customer',
      page: () => CustomerScreen(),
      binding: CustomerScreenBinding(),
    ),
    GetPage(
      name: '/customerbottomappbar',
      page: () => CustomerBottomAppBar(),
      binding: CustomerBottomNavBinding(),
    ),
    GetPage(
      name: '/serviceproviderbottomappbar',
      page: () => ServiceProviderBottomAppBar(),
      binding: ServiceProviderBottomNavBinding(),
    ),
    GetPage(
      name: '/serviceproviderhomepg',
      page: () => ServiceProviderHomeScreen(),
      binding: ServiceProviderHomeScreenBinding(),
    ),
  ];
}
