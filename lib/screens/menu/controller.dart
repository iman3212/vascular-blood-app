import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MenuScreenController extends GetxController {
  // Selected item state, initialized to `general`
  RxInt selectedItem = 1.obs;
  RxString requestType = ''.obs;

  // Function to change the selected item
  void changeSelectedItem(int value) {
    if (value >= 1 && value <= 2) {
      selectedItem.value = value;
    } else {
      Logger()
          .w('Menu , Invalid value for selectedItem. It should be 0, 1, or 2.');
    }
  }

  Future<void> setType(int index) async {
    if (index >= 1 && index <= 2) {
      if (index == 1) {
        requestType.value = "diameter";
      } else if (index == 2) {
        requestType.value = "parameter";
      } else {
        requestType.value = "diameter";
      }
      Logger().i('User select $requestType item');
    }
  }

 
}
