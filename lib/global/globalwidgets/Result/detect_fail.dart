import 'package:vascular_blood/exports/modules.dart';

class DetectFail extends StatelessWidget {
  const DetectFail({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 110,
      child: Flexible(
        child: Container(
          // height: 100,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
                12.0), // Increased padding for better spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Failure Icon
                Image.asset(
                  "assets/images/fail.png",
                  height: size.height * 0.05, // Slightly increased size
                  width: size.width * 0.10,
                ),
                const SizedBox(height: 8), // Consistent spacing

                // Title
                Text(
                  "Detection Failure",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // Emphasize failure with red color
                      ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  "Our AI couldn't detect the vessel in the image, possibly due to:",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign:
                      TextAlign.justify, // Centered for better readability
                ),
                const SizedBox(height: 8),

                // Reasons List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReasonItem(
                      context,
                      "The image angle may not be optimal for detection.",
                    ),
                    _buildReasonItem(
                      context,
                      "The image may be blurry or unclear.",
                    ),
                    _buildReasonItem(
                      context,
                      "The size of the artificial vessel may fall outside the expected range.",
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Suggestion
                // Text(
                //   "To improve results, please capture a new image with better lighting and ensure the area of interest is clearly visible.",
                //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //         fontStyle: FontStyle.italic, // Italicized for emphasis
                //       ),
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build consistent reason items
  Widget _buildReasonItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "\u2022 ",
            style:
                TextStyle(color: Colors.red, fontSize: 15), // Red bullet point
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color:
                        Colors.red, // Consistent red color for failure reasons
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
