import 'package:get/get.dart';
import 'package:interview_project/Controller/service_provider_home_controller.dart';

class ServiceProviderHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProviderHomeController>(() => ServiceProviderHomeController());
  }
}