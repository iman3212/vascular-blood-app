import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  LoginTextfield(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      this.obscureText,
      this.obscureIcon, required this.isPassword, required this.isEmail});

  final TextEditingController controller;
  final String label;
  final Icon icon;
  bool? obscureText;
  IconButton? obscureIcon;
  final bool isPassword;
  final bool isEmail;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    // Email pattern for basic email format validation
    String emailPattern = r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    if (!RegExp(emailPattern).hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required ";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Needs at least 1 uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Needs at least one number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Needs at least one special character(@ , &, ...)";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (isPassword) {
          return validatePassword(value);
        } else if(isEmail) {
          return validateEmail(value);
        }else if (value == null || value.isEmpty) {
      return "This field is required";
    }
      },
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: obscureIcon,
          ),
          prefixIcon: icon,
          label: Text(
            label,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
              errorStyle:const TextStyle( color: Colors.red, // Change the color of error message
          fontSize: 14, // Change font size of error message
          fontWeight: FontWeight.w400) // Change the font weight
              
              ),

      controller: controller,
    );
  }
}
