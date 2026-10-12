import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui' as ui;
import 'package:vascular_blood/theme/color.dart';

class ButtonStyles {
  // Primary button style configuration
  static ButtonStyle primaryButton(BuildContext context) {
    return ElevatedButton.styleFrom(
      maximumSize: Size(MediaQuery.of(context).size.width, 55),
      minimumSize: Size(MediaQuery.of(context).size.width, 55),
      backgroundColor: const Color.fromARGB(255, 16, 15, 15), // Setting background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Button shape with rounded corners
      ),
    );
  }


  // Secondary button style configuration
  final secondaryButton = ButtonStyle(
      // side: MaterialStatePropertyAll(
      //     BorderSide(color: LightThemeColor.primaryColor, width: 2)),
      backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 222, 233, 247)), // Background color
      maximumSize: const WidgetStatePropertyAll(Size(75, 60)), // Maximum size for the button
      minimumSize: WidgetStateProperty.all(
        const Size(75, 60),
        // Adjust button size
      ),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12)))); // Button shape with rounded corners

  // Dialog button style configuration
  final dialogButton = ButtonStyle(
      maximumSize: const WidgetStatePropertyAll(Size(82, 60)), // Maximum size for the button
      backgroundColor: const WidgetStatePropertyAll(
          LightThemeColor.primaryColor), // Background color
      minimumSize: const WidgetStatePropertyAll(Size(80, 60)), // Minimum size for the button
      foregroundColor: const WidgetStatePropertyAll(
          LightThemeColor.primaryColor), // Foreground color (text color)
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12), // Button shape with rounded corners
      )));

  // Onboarding button style configuration
  final onboardingButton = ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(
          LightThemeColor.primaryColor), // Background color
      minimumSize: const WidgetStatePropertyAll(Size(200, 60)), // Minimum size for the button
      foregroundColor: const WidgetStatePropertyAll(
          LightThemeColor.onPrimary), // Foreground color (text color)
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12)))); // Button shape with rounded corners
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed; // Callback function to handle button press
  final String text; // Text to be displayed on the button
  final bool? processing; // Flag to indicate if processing animation should be shown

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.processing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Assigning the callback function to the button press event
      style: ElevatedButton.styleFrom(
          maximumSize: Size(MediaQuery.of(context).size.width, 55), // Maximum size for the button
          minimumSize: Size(MediaQuery.of(context).size.width, 55), // Minimum size for the button
          backgroundColor: const Color.fromARGB(255, 16, 15, 15), // Background color
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10))), // Button shape with rounded corners
      child: processing != null && processing!
          ? const SpinKitThreeBounce(
              color: Colors.white, // Color of the animation
              size: 22, // Size of the animation
            )
          : Text(
              text, // Displaying the text on the button
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 18,
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.w600), // Text font weight
            ),
    );
  }
}
