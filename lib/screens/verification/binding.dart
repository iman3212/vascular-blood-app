import 'package:get/get.dart';
import 'package:vascular_blood/screens/verification/controller.dart';

class AccountVerification extends Bindings {
  @override
  void dependencies() {
    Get.put(VerificationController());
  }
}