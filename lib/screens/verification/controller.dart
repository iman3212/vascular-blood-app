import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/error.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/success.dart';
import 'package:vascular_blood/services/exceptions_massage.dart';
import 'package:dio/dio.dart' as dio; // Use 'dio' as prefix for Dio package

class VerificationController extends GetxController {
  RxBool enableButton = false.obs;

  var processing = false.obs;

  var isProcessing = false.obs;

  Future<void> checkOtp(String verificationCode) async {
    processing.value = true;
    try {
      final String? urlToken = await StorageService.getUrlToken();
      if (urlToken != null) {
        final String endPoint = 'account/api/checkotp?token=$urlToken';

        final formData = dio.FormData.fromMap({
          "code": verificationCode,
        });
        Logger().i("end point is : $endPoint , formdata is ${formData.fields}");
        final response = await NetworkService()
            .post(endPoint, false, formData, type: RequestType.CheckOtp);
        if (response != null && response.statusCode == 200) {
          if (response.data["Token"] != null) {
            await StorageService.saveToken(response.data["Token"] as String);
            Logger().i('sign in , Token : ${response.data["Token"]}');
            const SuccessSnackBar(
              title: 'Successful',
              content: 'Your authentication was successful',
            ).show();

            // check user come from which page
            String origin = await Get.arguments;

            if (origin == 'signup') {
              final firstTime = await StorageService.firstTimeGet();
              if (firstTime) {
                Get.offAllNamed(Routes.onboarding);
              } else {
                Get.offAllNamed(Routes.onboarding);
              }
            } else if (origin == 'checkEmail') {
              Get.offNamed(Routes.newpassword);
            }
          } else {
            Logger().w('sign in  , Token value is null !');
            const ErrorSnackBar(
              title: 'Erorr',
              content:
                  'There is a problem with the server, please inform the IT expert',
            ).show();
          }
        } else {
          if (response == null) {
            Logger().i(
                'sign in , response is null so it means we have an error or server send null response !');
          } else {
            if (response.data == null) {
              Logger().i(
                  'sign in , response data section is null , request status code is ${response.statusCode} !');
              const ErrorSnackBar(
                title: 'Erorr',
                content:
                    'There is a problem with the server, please inform the IT expert',
              ).show();
            }
          }
        }
      } else {
        Logger().e("our url token value is null");
        return;
      }
    } finally {
      processing.value = false;
    }
  }

  Future<void> tokenExpired() async {
    await StorageService.removeUrlToken();
    enableButton.value = true;
    Logger().i("verification page , Expired Token removed from memory");
  }

  Future<bool> resendUrlToken() async {
    bool result = false;
    isProcessing.value = true;
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
          result = true;
          enableButton.value = false;

          Logger().i(
              'verification page , Temprary Token is  : ${response.data["url_token"]}');
        } else {
          result = false;
        }
      }
    } catch (e) {
      Logger().i('verification page , Temprary Token failed');
    } finally {
      isProcessing.value = false;
    }

    return result;
  }
}
