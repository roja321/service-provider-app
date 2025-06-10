import 'package:get/get.dart';
import 'package:interview_project/Controller/customer_bottom_app_bar_controller.dart';

class CustomerBottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerBottomController>(() => CustomerBottomController());
  }
}
