import 'package:get/get.dart';
import 'package:vascular_blood/screens/sign-up/controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
