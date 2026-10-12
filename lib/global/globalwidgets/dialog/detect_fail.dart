
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/theme/theme.dart';

class DetectFailDialog {
  void showDialog() {
    final smallScreen = MediaQuery.of(Get.context!).size.width < 300 ? true : false;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Rounded corners for the dialog
        ),
        contentPadding:
            EdgeInsets.zero, // Remove default padding for custom layout
        content: SizedBox(
          height: MediaQuery.of(Get.context!).size.height *
              0.7, // Adjusted dynamic height
          width: MediaQuery.of(Get.context!).size.width *
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
                    width: MediaQuery.of(Get.context!).size.width * 0.8,
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
              // Content below the image
              Positioned(
                top:
                    40, // Adjust position of the content to slightly overlap the image
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Fail icon centered
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
                                color: const Color.fromARGB(255, 253, 231, 231),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/fail.png',
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Failure message
                        Text(
                          'Failure to recognize',
                          style: AppTheme()
                              .lightTheme
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: smallScreen?16:20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // Description text
                        Text(
                          'Unfortunately, our AI was unable to detect this field in the image. This can happen for several reasons, such as:',
                          style: AppTheme()
                              .lightTheme
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Colors.grey.shade700,
                                fontSize: smallScreen?14:16,
                                fontWeight: FontWeight.w400,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // Reason list
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\u2022 The image angle may not be optimal.",
                              style: AppTheme()
                                  .lightTheme
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "\u2022 The image could be blurred or unclear.",
                              style: AppTheme()
                                  .lightTheme
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "\u2022 The artificial vessel size might be unexpected.",
                              style: AppTheme()
                                  .lightTheme
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Final instruction message
                        Text(
                          "Please try capturing a new image with better lighting and a clearer view of the area.",
                          style: AppTheme()
                              .lightTheme
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Colors.grey.shade700,
                                  fontSize: smallScreen?14:16,
                                fontWeight: FontWeight.w400,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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
