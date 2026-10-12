import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/theme/theme.dart';

class ResultInstructionDialog {
  void showResultInstructionDialog({required bool isLandScape}) {
    final smallScreen =
        MediaQuery.of(Get.context!).size.width > 300 ? false : true;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Rounded corners for the dialog
        ),
        contentPadding:
            EdgeInsets.zero, // Remove default padding for custom layout
        content: SizedBox(
          height:
             isLandScape? MediaQuery.of(Get.context!).size.height * 0.9: MediaQuery.of(Get.context!).size.height * 0.53, // Dynamic height
          width: isLandScape?MediaQuery.of(Get.context!).size.width * 0.4 :MediaQuery.of(Get.context!).size.width *
              0.8, // Dynamic width for the dialog
          child: Stack(
            children: [
              // Dialog image at the top with rounded corners
              Positioned(
                top: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20), // Rounded top corners
                  ),
                  child: Image.asset(
                    "assets/images/dialog.jpg",
                    width:isLandScape?MediaQuery.of(Get.context!).size.width * 0.4 :MediaQuery.of(Get.context!).size.width * 0.8,
                    height: 100, // Height for the dialog image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Close button at the top right
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.back(); // Close the dialog when tapped
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              // Dialog content below the image
              Positioned(
                top:
                    40, // Adjusting the position of the content to overlap slightly with the image
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      // Centered lamp icon
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: const Color.fromARGB(255, 253, 251, 231),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/lamp.png',
                                width: 55,
                                height: 55,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Title text
                      SingleChildScrollView(
                        child: Column(children: [
                          Text(
                            'Instruction',
                            style: AppTheme().lightTheme.textTheme.titleMedium!.copyWith(fontSize: smallScreen?16:20),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          // Instruction text
                          Text(
                            'Place the artificial vessel under the microscope and capture an image. Then, flip it over, position the other side under the microscope, and take another image.',
                            style: AppTheme()
                                .lightTheme
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Colors.grey.shade700,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          // Buttons at the bottom
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    Get.back(); // Dismiss dialog
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                  onPressed: () async {
                                    await StorageService.firstTimeSet(false);
                                    Get.back(); // Dismiss dialog
                                  },
                                  child: const Text(
                                    'Do not show again!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
