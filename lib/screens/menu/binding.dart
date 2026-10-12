import 'package:get/get.dart';
import 'package:vascular_blood/screens/menu/controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuScreenController());
  }
}
