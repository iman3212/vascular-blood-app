import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vascular_blood/theme/theme.dart';

class WifiDialog {
  void showWifiDialog() {
    final double dialogHeight = MediaQuery.of(Get.context!).size.height * 0.45;
    final double dialogWidth = MediaQuery.of(Get.context!).size.width * 0.8;
    final smallScreen =
        MediaQuery.of(Get.context!).size.width > 300 ? false : true;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Rounded corners for top and bottom
        ),
        contentPadding:
            EdgeInsets.zero, // Remove default padding for custom layout
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: dialogHeight, // Responsive height
            width: dialogWidth, // Responsive width
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    "assets/images/dialog.jpg",
                    width: dialogWidth,
                    height: dialogHeight * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
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
                Positioned(
                  top:
                      40, // Position the logo to slightly overlap with the dialog image
                  left: (MediaQuery.of(Get.context!).size.width * 0.75) / 2 -
                      27.5, // Center the logo horizontally
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60)),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
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
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dialogWidth * 0.05, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Incorrect Wi-Fi connection',
                            style: AppTheme()
                                .lightTheme
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: smallScreen ? 16 : 20),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'You are connected to the wrong Wi-Fi. Please connect to the microscope Wi-Fi:',
                            style: AppTheme().lightTheme.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 253, 231, 231),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                             "MKL_WIFI_0A34CC",
                                style: AppTheme()
                                    .lightTheme
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.red,
                                        fontSize: smallScreen ? 14 : 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                Get.back(); // Close the dialog
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
      ),
    );
  }
}
