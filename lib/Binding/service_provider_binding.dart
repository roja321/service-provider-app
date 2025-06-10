import 'package:get/get.dart';
import 'package:interview_project/Controller/service_provider_screen_controller.dart';
import 'package:interview_project/Controller/customer_screen_controller.dart';

class ServiceProviderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProviderScreenController>(() => ServiceProviderScreenController());
  }
}