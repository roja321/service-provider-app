import 'package:get/get.dart';
import 'package:interview_project/Controller/customer_screen_controller.dart';

class CustomerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerScreenController>(() => CustomerScreenController());
  }
}