import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final int selectedIndex;
  final VoidCallback onPressed;
  final Text title;
  final int index;

  const Filter({
    super.key,
    required this.selectedIndex,
    required this.onPressed, required this.title, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          child: title,
    
        ),
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }
}
