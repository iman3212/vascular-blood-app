import 'package:get/get.dart';
import 'package:vascular_blood/screens/spash/controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(), permanent: true);
  }
}
