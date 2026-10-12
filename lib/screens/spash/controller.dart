import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/error.dart';
import 'package:vascular_blood/routes/route.dart';
import 'package:vascular_blood/storage/shared_perefrence.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    navigation();
    super.onReady();
  }

  Future<void> navigation() async {
    try {
      String? tokenRead = await StorageService.getToken();
      Logger().i('splash page , token: $tokenRead');
      await Future.delayed(const Duration(seconds: 3));
      if (tokenRead == null || tokenRead.isEmpty) {
        Get.offNamed(Routes.signIn);
      } else {
        Get.offNamed(Routes.menu);
      }
    } catch (e, stackTrace) {
      Logger().e('$e , $e\nStack Trace: $stackTrace');
      const ErrorSnackBar(
        title: 'Error',
        content: 'Something went wrong, please try again',
      ).show();
    }
  }
}
