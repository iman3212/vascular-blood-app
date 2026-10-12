import 'dart:async';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/error.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/success.dart';
import 'package:vascular_blood/services/alert.dart';
import 'package:vascular_blood/services/exceptions_massage.dart';

class LoginController extends GetxController {
  ExceptionAlert alertDialog = ExceptionAlert();

  var processing = false.obs;

  var isProcessing = false.obs;

// Managing observe password
  var obscureText = true.obs;
  void obscure() {
    obscureText.value = !obscureText.value;
  }

  Future<void> loginTokenRequest(String username, String password) async {
    try {
      processing.value = true;

      final response = await NetworkService().post(
          "account/api/login", false, {"email": username, "password": password},
          type: RequestType.LOGIN);
      Logger().i('$response');
      if (response != null &&
          response.data != null &&
          response.statusCode == 200) {
        if (response.data["Token"] != null) {
          await StorageService.saveToken(response.data["Token"] as String);
          Logger().i('sign in , Token : ${response.data["Token"]}');

          const SuccessSnackBar(
            title: 'Successful',
            content: 'Your authentication was successful',
          ).show();

          Get.offAllNamed(Routes.menu);
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
    } finally {
      processing.value = false;
    }
  }
}
