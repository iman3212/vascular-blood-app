import 'dart:io';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/storage/getx.dart';

import 'package:vascular_blood/screens/menu/controller.dart';
import 'package:vascular_blood/services/model/diameter_model.dart';
import 'package:vascular_blood/services/model/parameter_model.dart';

class ResultsController extends GetxController {
  // Inject the MenuScreenController
  final MenuScreenController menuController = Get.find<MenuScreenController>();

//Inject the MicroController
  final MainController controller = Get.find<MainController>();

  // Set data to null initially
  var data = Rx<dynamic>(null);

  String? type = "";

  // for loading data
  var isLoading = false.obs;

  RxBool isConnected = true.obs;

  // Add error message observable
  RxString errorMessage = ''.obs;

  // microscope vein front image
  late File frontVeinImage;

  late File backVeinImage;

  //needle table
  RxList needleList = [].obs;

  RxInt selectedItem = 0.obs;
  

  @override
  void onInit() {
    super.onInit();
    frontVeinImage = controller.capturedImages[0]!;
    Logger().i("'first image data is '${controller.capturedImages[0]}");
    backVeinImage = controller.capturedImages[1]!;
    Logger().i("'secound image data is '${controller.capturedImages[1]}");

    aiResult(frontVeinImage, backVeinImage);
  }

  Future<void> aiResult(frontImage, backImage) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final mode = menuController.requestType.value;
      type = mode;
      Logger().i('our front image is $frontImage , and our mode is $type');
      Logger().i('our back image is $backImage , and our mode is $type');
      Logger().i('Vein image type: ${frontVeinImage.runtimeType}, Mode: $type');

      final response =
          // await NetworkService().uploadImage(frontImage, backImage, mode);
           await NetworkService().uploadImage(mode);
      if (response?.statusCode == 200 &&
          response != null &&
          response.data != null) {
        Map<String, dynamic> jsonResponse =
            response.data as Map<String, dynamic>;

        if (mode == "parameter") {
          data.value = ParameterClass.fromJson(jsonResponse);
        } else if (mode == "diameter") {
          data.value = DiameterClass.fromJson(jsonResponse);
        }
      } else {
        errorMessage.value =
            "Failed to fetch data. Status code: ${response?.statusCode}";
        data.value = null; // Clear data in case of failure
      }
    } on NetworkException catch (e) {
      // Handle internet connection error
      // Output: NetworkException: No internet connection
      isConnected.value = false;
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      Logger().e('Exception during image upload: $e');
      data.value = null; // Clear data in case of exception
    } finally {
      isLoading.value = false; // Set loading to false after the request
    }
  }
}
