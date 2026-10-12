import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WarningSnackbar extends StatelessWidget {  
  const WarningSnackbar({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return  SnackBar(
      content: Column(
        children: [
          Text(title),
          Text(content)
        ],
      ),
      duration: const Duration(seconds: 3),
    );
  }

  void show() {
    Get.snackbar(
      title,
      content,
      icon: const Icon(
        Icons.warning,
        color: Colors.red,
      ),
      instantInit: true,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      borderRadius: 10,
      overlayBlur: 2,
      leftBarIndicatorColor: Colors.red,
      colorText: Colors.black,
      duration: const Duration(seconds: 3),
    );
    // print(errorMessage);
  }
}
