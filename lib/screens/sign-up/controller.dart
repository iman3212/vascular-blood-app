import 'dart:async';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/error.dart';
import 'package:vascular_blood/services/alert.dart';
import 'package:vascular_blood/services/exceptions_massage.dart';
import 'package:dio/dio.dart' as dio; // Use 'dio' as prefix for Dio package

class RegisterController extends GetxController {
  ExceptionAlert alertDialog = ExceptionAlert();

  var processing = false.obs;

// Managing observe password
  var obscureText = true.obs;
  void obscure() {
    obscureText.value = !obscureText.value;
  }

  Future<void> registerTokenRequest(
      String email, String fullname, String password) async {
    try {
      processing.value = true;

      final formData = dio.FormData.fromMap({
        "email": email,
        "full_name": fullname,
        "password": password,
      });

      // Post the form data
      final response = await NetworkService().post(
        "account/api/register",
        false,
        formData,
        type: RequestType.Register,
      );

      Logger().i('$response');
      if (response != null &&
          response.data != null &&
          response.statusCode == 201) {
        if (response.data["url_token"] != null) {
          await StorageService.saveUrlToken(
              response.data["url_token"] as String);
          Logger().i(
              'sign in , Temprary Token is  : ${response.data["url_token"]}');
          Get.offNamed(Routes.verification, arguments: 'signup');
        } else {
          Logger().w('sign in  , Temprary Token value is null !');
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
