import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class ConnectionTimeoutDialog {
//   void showConnectionTimeoutDialog(
//       {required Function onRetry, required Function onOpenSettings}) {
//     final smallScreen =
//         MediaQuery.of(Get.context!).size.width > 300 ? false : true;
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius:
//               BorderRadius.circular(20), // Rounded corners for the dialog
//         ),
//         contentPadding:
//             EdgeInsets.zero, // Remove default padding for custom layout
//         content: SizedBox(
//           height:
//               MediaQuery.of(Get.context!).size.height * 0.85, // Dynamic height
//           width: MediaQuery.of(Get.context!).size.width * 0.4, // Dynamic width
//           child: Stack(
//             children: [
//               // Dialog image at the top with rounded corners
//               Positioned(
//                 top: 0,
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(20), // Rounded top corners
//                   ),
//                   child: Image.asset(
//                     "assets/images/dialog.jpg",
//                     width: MediaQuery.of(Get.context!).size.width * 0.4,
//                     height: 100, // Height for the dialog image
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               // Close button at the top right
//               Positioned(
//                 top: 10,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.back(); // Close the dialog
//                     onRetry();
//                   }, // Close the dialog
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(60),
//                       border: Border.all(color: Colors.white),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.all(3.0),
//                       child: Icon(
//                         Icons.close,
//                         color: Colors.white,
//                         size: 22,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Dialog content
//               Positioned(
//                 top: 60, // Overlapping content below the image
//                 left: 0,
//                 right: 0,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     child: Column(
//                       children: [
//                         // Centered logout icon
//                         Container(
//                           height: 70,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(60),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 70,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(60),
//                                 color: const Color.fromARGB(255, 253, 231, 231),
//                               ),
//                               child: Center(
//                                 child: Image.asset(
//                                   'assets/images/log-out-icon.png',
//                                   width: 55,
//                                   height: 55,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // Title
//                         Text(
//                           'Connection Timeout',
//                           style: Theme.of(Get.context!)
//                               .textTheme
//                               .titleMedium!
//                               .copyWith(color: Colors.black),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 10),
//                         // Description
//                         Text(
//                           'Please connect to the Wi-Fi of the microscope and try again',
//                           style: Theme.of(Get.context!).textTheme.bodySmall,
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 20),
//                         // Buttons
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextButton(
//                               style: TextButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                               ),
//                               onPressed: () {
//                                 Get.back(); // Close the dialog
//                                 onRetry(); // Call the retry function
//                               },
//                               child: const Text(
//                                 'Retry',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 30),
//                             TextButton(
//                               style: TextButton.styleFrom(
//                                 backgroundColor: Colors.grey.shade300,
//                               ),
//                               onPressed: () {
//                                 Get.back(); // Close the dialog
//         //                          SystemChrome.setPreferredOrientations([
//         //   DeviceOrientation.landscapeRight,
//         //   DeviceOrientation.landscapeLeft,
//         //   DeviceOrientation.portraitUp,
//         //   DeviceOrientation.portraitDown,
//         // ]);
//                                 onOpenSettings(); // Call the open settings function
//                               },
//                               child: const Text(
//                                 'Open Settings',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ConnectionTimeoutDialog {
  void showConnectionTimeoutDialog({
    required Function onRetry,
    required Function onCancel,
  }) {
    final context = Get.context!;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    // Adjust height and width based on orientation
    final dialogHeight = isLandscape
        ? MediaQuery.of(context).size.height * 0.85
        : MediaQuery.of(context).size.height * 0.4;
    final dialogWidth = isLandscape
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.8;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Rounded corners for the dialog
        ),
        contentPadding:
            EdgeInsets.zero, // Remove default padding for custom layout
        content: SizedBox(
          height: dialogHeight, // Dynamic height based on orientation
          width: dialogWidth, // Dynamic width based on orientation
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
                    width: dialogWidth, // Use dynamic width
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
                    Get.back(); // Close the dialog
                    onCancel();
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
              // Dialog content
              Positioned(
                top: 60, // Overlapping content below the image
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        // Centered logout icon
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
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
                                  'assets/images/log-out-icon.png',
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Title
                        Text(
                          'Connection Failed',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // Description
                        Text(
                          'Please check your connection to the microscope and try again',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                onRetry(); // Call the retry function
                              },
                              child: const Text(
                                'Retry',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                              ),
                              onPressed: () {
                                onCancel(); // Call the open settings function
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
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
