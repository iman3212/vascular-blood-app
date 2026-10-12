import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:vascular_blood/exports/modules.dart';

class MenuHeaderItem extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final VoidCallback func;
  final String buttonText;

  const MenuHeaderItem({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.func,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis, // Prevents overflow
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Flexible(
              child: Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),

                overflow: TextOverflow.ellipsis, // Prevents overflow
                maxLines:
                    2, // Limiting to 2 lines to avoid too much content overflow
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedButton(
          height: 35,
          width: 85,
          isReverse: true,
          selectedTextColor: Colors.black,
          transitionType: TransitionType.LEFT_TOP_ROUNDER,
          textStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
          backgroundColor: Colors.transparent,
          borderColor: Colors.white,
          selectedBackgroundColor: Colors.white,
          borderRadius: 8,
          borderWidth: 1.5,
          text: buttonText,
          onPress: func,
        ),
      ],
    );
  }
}
