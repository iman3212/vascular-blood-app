import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSnackBar extends StatelessWidget {
  final String title;
  final String content;

  const SuccessSnackBar({super.key, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return const SnackBar(
        content: Column(
      children: [],
    ),
    duration: Duration(seconds: 3),
    );
  }

  void show() {
    Get.snackbar(
      title,
      content,
      icon: const Icon(
        Icons.check,
        color: Colors.black,
      ),
      instantInit: true,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey.shade300,
      borderRadius: 10,
      overlayBlur: 2,
      leftBarIndicatorColor: Colors.black,
      colorText: Colors.black,
      duration: const Duration(seconds: 3),
    );
    // print(errorMessage);
  }
}
