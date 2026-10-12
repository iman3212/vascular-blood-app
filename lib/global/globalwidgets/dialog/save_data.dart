import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/success.dart';
import 'package:vascular_blood/theme/theme.dart';

class SaveData {
  void showsaveDialog({required int id}) {
    final smallScreen = MediaQuery.of(Get.context!).size.width <= 300;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        contentPadding: EdgeInsets.zero, // Remove default padding
        content: SizedBox(
          height: MediaQuery.of(Get.context!).size.height * 0.45,
          width: MediaQuery.of(Get.context!).size.width * 0.8,
          child: Stack(
            children: [
              // Dialog Image
              Positioned(
                top: 0,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    "assets/images/dialog.jpg",
                    width: MediaQuery.of(Get.context!).size.width * 0.8,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Close Button
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: Colors.white),
                    ),
                    padding: const EdgeInsets.all(3.0),
                    child:
                        const Icon(Icons.close, color: Colors.white, size: 22),
                  ),
                ),
              ),
              // Dialog Content
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        // Save Icon
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
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
                        const SizedBox(height: 20),
                        // Title
                        Text(
                          'Save Data',
                          style: AppTheme()
                              .lightTheme
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Colors.black,
                                fontSize: smallScreen ? 16 : 20,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // Confirmation Text
                        Text(
                          'Would you like to save this data?',
                          style: AppTheme().lightTheme.textTheme.bodySmall!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                Get.offNamed(Routes.menu);
                                const SuccessSnackBar(
                                  title: 'Successfull !',
                                  content:
                                      'Your data has been saved successfully.',
                                ).show();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 30),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey.shade300),
                              onPressed: () async {
                                await NetworkService().removeData(id);
                                Get.offNamed(Routes.menu);
                                const SuccessSnackBar(
                                  title: 'Successfull !',
                                  content:
                                      'Your data has been removed successfully.',
                                ).show();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
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
