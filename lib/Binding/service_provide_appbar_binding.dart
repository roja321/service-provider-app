import 'package:get/get.dart';
import 'package:interview_project/Controller/customer_bottom_app_bar_controller.dart';
import 'package:interview_project/Controller/service_provide_appbar_controller.dart';

class ServiceProviderBottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProviderBottomAppBarController>(() => ServiceProviderBottomAppBarController());
  }
}
