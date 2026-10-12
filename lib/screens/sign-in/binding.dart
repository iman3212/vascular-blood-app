import 'package:get/get.dart';
import 'package:vascular_blood/screens/sign-in/controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
