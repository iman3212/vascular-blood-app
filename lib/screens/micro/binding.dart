import 'package:get/get.dart';
import 'package:vascular_blood/screens/micro/controller.dart';

class MicroBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MicroController());
  }
}
