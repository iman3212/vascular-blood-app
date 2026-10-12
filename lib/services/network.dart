import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/error.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/warning.dart';
import 'package:vascular_blood/services/alert.dart';
import 'package:vascular_blood/services/exceptions_massage.dart';
import 'package:vascular_blood/storage/shared_perefrence.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  ExceptionAlert alertDialog = ExceptionAlert();

  factory NetworkService() => _instance;

  NetworkService._internal();

  final Dio _dio = Dio();

  static const String _baseUrl = 'http://vascular.hitechprojects.ir:8300/';
  static const String aiUrl =
      "http://vascular.hitechprojects.ir:8300/ai/api/get/values";

  Future<void> _setHeaders() async {
    var token = await StorageService.getToken();
    _dio.options.headers["Authorization"] = "Token $token";
  }

  void _setConfigurations() {
    // connectTimeout:
    // const Duration(seconds: 5);
    // receiveTimeout:
    // const Duration(seconds: 5);
    // _dio.options.sendTimeout = Duration(seconds: 5); // 5 seconds
  }

// define get function for better use from get method in dio

  Future<Response?> get(String endpoint,
      {RequestType type = RequestType.GET}) async {
    bool isConnected = await _isConnected();

    if (isConnected) {
      await _setHeaders();
      _setConfigurations();

      final String url = _baseUrl + endpoint;

      try {
        final response = await _dio.get(url);
        Logger().i(
            "The response back from server is : $response ,and response data part is :  ${response.data} , and response status code is :  ${response.statusCode}");
        return response;
      } catch (e) {
        if (e is DioException) {
          checkException(
            e,
            RequestType.GET,
          );
          Logger().e('$e');
        } else {
          const ErrorSnackBar(
              title: 'Error',
              content: 'An unexpected error occurred. Please try again later.');
          Logger().w('$e');
        }
      }
    } else {
      const WarningSnackbar(
              title: 'No internet connection',
              content: 'Please check your connection and try again!')
          .show();
    }
    return null;
  }

// define post function for better use from post method in dio

  Future<Response?> post(String endpoint, bool headerSet, dynamic data,
      {RequestType type = RequestType.POST}) async {
    //check your internet connection
    bool isConnected = await _isConnected();

    if (isConnected) {
      //check user have a token for setting header or not
      if (headerSet) {
        await _setHeaders();
      }

      _setConfigurations();

      String url = _baseUrl + endpoint;

      try {
        final response = await _dio.post(
          url,
          data: data,
        );
        return response;
      } catch (e) {
        if (e is DioException) {
          Logger().e(
              'sending request has this error : $e , e error is :  ${e.error} ,error massage is :  ${e.message}');

          checkException(
            e,
            type,
          );
        } else {
          const ErrorSnackBar(
              title: 'Error',
              content: 'An unexpected error occurred. Please try again later.');
          Logger().w('$e');
        }
      }
    } else {
      const WarningSnackbar(
              title: 'No internet connection',
              content: 'Please check your connection and try again!')
          .show();
    }
    return null;
  }

  Future<void> removeData(id) async {
    var token = await StorageService.getToken();
    _dio.options.headers["Authorization"] = "Token $token";
    final response = await _dio.delete(
      "http://vascular.hitechprojects.ir:8300/history/api/delete/dimeter/$id",
    );
  }
  // fake function

  Future<Response?> uploadImage(String mode) async {
    var token = await StorageService.getToken();
    _dio.options.headers["Authorization"] = "Token $token";

    final String typeValue =
        (mode == "diameter") ? "single_diameter" : "single_parameter";

    try {
      // خواندن فایل‌های تصویر از فولدر assets
      final ByteData frontImageData =
          await rootBundle.load('assets/images/vessel.jpg');
      final ByteData backImageData =
          await rootBundle.load('assets/images/vessel.jpg');

      // تبدیل ByteData به File
      final File frontImageFile =
          await _writeToFile(frontImageData, 'vessel.jpg');
      final File backImageFile =
          await _writeToFile(backImageData, 'vessel.jpg');

      // نام فایل‌ها
      final String frontFileImage = frontImageFile.path.split("/").last;
      final String backFileImage = backImageFile.path.split("/").last;

      // ایجاد FormData
      FormData paraFormData = FormData.fromMap(<String, dynamic>{
        "image": await MultipartFile.fromFile(frontImageFile.path,
            filename: frontFileImage),
        "type": typeValue,
      });

      FormData diaFormData = FormData.fromMap(<String, dynamic>{
        "front": await MultipartFile.fromFile(frontImageFile.path,
            filename: frontFileImage),
        "back": await MultipartFile.fromFile(backImageFile.path,
            filename: backFileImage),
        "type": typeValue,
      });

      // چک کردن اطلاعات قبل از ارسال درخواست
      Logger().i(
          'front path : ${frontImageFile.path} and front file image is $frontFileImage');
      Logger().i(
          'back path : ${backImageFile.path} and back file image is $backFileImage');
      Logger().i('FormData , Files: ${diaFormData.files} ');
      Logger().i(
          'Sending to URL: $aiUrl and Headers: ${_dio.options.headers} and Files: ${paraFormData.files} ');

      _dio.options.connectTimeout = Duration(seconds: 30);

      final response = await _dio.post(
        aiUrl,
        data: mode == "diameter" ? diaFormData : paraFormData,
      );

      Logger().i("Request headers: ${response.requestOptions.headers}");
      return response;
    } catch (e) {
      if (e is DioException) {
        checkException(e, RequestType.POST);
        if (e.type == DioExceptionType.connectionError) {
          Logger().e("$e");
          throw NetworkException('Internet connection error');
        }

        Logger().e("$e");
        Logger().e("error message is :  ${e.message}");
      } else {
        // اگر خطا مربوط به Dio نباشد
        const ErrorSnackBar(
            title: 'Error',
            content: 'An unexpected error occurred. Please try again later.');
        Logger().w('$e');
      }
    }
    return null;
  }

  Future<File> _writeToFile(ByteData data, String fileName) async {
    final buffer = data.buffer;
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    return file.writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
//..............................................................
  // Future<Response?> uploadImage(
  //   frontImageFile,
  //   backImageFile,
  //   String mode,
  // ) async {

  //   var token = await StorageService.getToken();
  //   _dio.options.headers["Authorization"] = "Token $token";

  //   final String typeValue =
  //       (mode == "diameter") ? "single_diameter" : "single_parameter";

  //   if (true) {
  //     RequestType type = RequestType.POST;
  //     Logger().i(' Front image type is : ${frontImageFile.runtimeType}');
  //     Logger().i(' bakc image type is : ${backImageFile.runtimeType}');
  //     // set image file path and name
  //     final String? frontFileImage = frontImageFile is File
  //         ? frontImageFile.path.split("/").last
  //         : frontImageFile.files.first.name ?? 'default_name';

  //     final String? backFileImage = backImageFile is File
  //         ? backImageFile.path.split("/").last
  //         : backImageFile.files.first.name ?? 'default_name';

  //     final String backPath = backImageFile is File
  //         ? backImageFile.path
  //         : backImageFile.file.first.path;

  //     final String frontPath = frontImageFile is File
  //         ? frontImageFile.path
  //         : frontImageFile.files.first.path;
  //     Logger().i(
  //         'File info - FileName: $frontFileImage, FilePath: $frontPath, Type: $typeValue');
  //     Logger().i(
  //         'File info - FileName: $backFileImage, FilePath: $backPath, Type: $typeValue');

  //     if (frontPath == null && backPath == null) {
  //       Logger().e('our file path is null !');
  //       return null;
  //     }

  //     // creating form data
  //     FormData paraFormData = FormData.fromMap(<String, dynamic>{
  //       "image":
  //           await MultipartFile.fromFile(frontPath, filename: frontFileImage),
  //       "type": typeValue,
  //     });
  //     // creating form data
  //     FormData diaFormData = FormData.fromMap(<String, dynamic>{
  //       "front":
  //           await MultipartFile.fromFile(frontPath, filename: frontFileImage),
  //       "back": await MultipartFile.fromFile(backPath, filename: backFileImage),
  //       "type": typeValue,
  //     });
  //     // check all information before sending request
  //     Logger()
  //         .i('front path : $frontPath and front file image is $frontFileImage');
  //     Logger()
  //         .i('front path : $backPath and front file image is $backFileImage');
  //     Logger().i('FormData , Files: ${diaFormData.files} ');
  //     Logger().i(
  //         ' Sending to URL: $aiUrl and Headers: ${_dio.options.headers}and  Files: ${paraFormData.files} ');
  //     _dio.options.connectTimeout = Duration(seconds: 30);
  //     try {
  //       final response = await _dio.post(
  //         aiUrl,
  //         data: mode == "diameter" ? diaFormData : paraFormData,
  //       );
  //       Logger().i("Request headers: ${response.requestOptions.headers}");
  //       return response;
  //     } catch (e) {
  //       if (e is DioException) {
  //         checkException(e, type);
  //         if (e.type == DioExceptionType.connectionError) {
  //           Logger().e("$e");
  //           throw NetworkException('Internet connection error');
  //         }

  //         Logger().e("$e");
  //         Logger().e("error massage is :  ${e.message}");
  //       } else {
  //         // if our error is not dio error
  //         const ErrorSnackBar(
  //             title: 'Error',
  //             content: 'An unexpected error occurred. Please try again later.');
  //         Logger().w('$e');
  //       }
  //     }
  //   } else {
  //     // if user is disconnected to internet
  //     const WarningSnackbar(
  //             title: 'No internet connection',
  //             content: 'Please check your connection and try again!')
  //         .show();
  //   }
  //   return null;
  // }

  void checkException(
    DioException error,
    RequestType rtpype,
  ) {
    ApiException exception = ApiException();
    List<String> errorMessage = exception.getExceptionMessage(error, rtpype);
    WarningSnackbar(title: errorMessage[0], content: errorMessage[1]).show();
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}
