import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/error.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/success.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vascular_blood/services/exceptions_massage.dart'; // Use 'dio' as prefix for Dio package

class ForgetPasswordController extends GetxController {
  var processing = false.obs;

  var isProcessing = false.obs;

// Managing observe password
  var obscureText = true.obs;
  void obscure() {
    obscureText.value = !obscureText.value;
  }

  Future<void> recoveryPassword(password, repeatePassword) async {
    try {
      isProcessing.value = true;
      final String? token = await StorageService.getToken();
      Logger().i(
          'token is : $token , password is : $password , repeat password is : $repeatePassword');
      final formData = dio.FormData.fromMap({
        "token": token,
        "new_password": password,
        "new_password2": repeatePassword,
      });

      final recoveryResponce = await NetworkService().post(
          'account/api/forget/password', false, formData,
          type: RequestType.NewPassword);
      if (recoveryResponce != null && recoveryResponce.statusCode == 200) {
        const SuccessSnackBar(
                title: 'Success',
                content:
                    'The new password has been successfully sent to your email')
            .show();
        Get.offNamed(Routes.menu);
      }
    } catch (e) {
      Logger().e("forget password error ,  $e");
      const ErrorSnackBar(
              title: 'Error',
              content: 'Failed to recover password , Please try again later')
          .show();
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> checkEmail() async {
    final email = await StorageService.getEmail();
    Logger().i('Email value is : $email');
    final formData = dio.FormData.fromMap({
      "email": email,
    });

    try {
      isProcessing.value = true;
      final response = await NetworkService().post(
          'account/api/send/otp', false, formData,
          type: RequestType.SendOtp);
      if (response != null && response.statusCode == 200) {
        if (response.data["url_token"] != null) {
          await StorageService.saveUrlToken(
              response.data["url_token"] as String);
          Get.toNamed(Routes.verification, arguments: 'checkEmail');

          Logger().i(
              'verification page , Temprary Token is  : ${response.data["url_token"]}');
        } else {}
      }
    } catch (e) {
      Logger().i('verification page , Temprary Token failed');
    } finally {
      isProcessing.value = false;
    }
  }
}
