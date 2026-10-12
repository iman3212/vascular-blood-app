import 'package:get/get.dart';
import 'package:vascular_blood/screens/result/controller.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResultsController());
  }
}
