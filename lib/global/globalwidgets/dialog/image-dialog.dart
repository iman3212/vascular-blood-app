import 'package:vascular_blood/exports/modules.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.pic});

  final String pic;

  @override
  Widget build(BuildContext context) {
    // Calculate dynamic width and height
    final width =
        MediaQuery.of(context).size.width * 0.8; // 80% of screen width
    final height =
        MediaQuery.of(context).size.height * 0.6; // 60% of screen height

    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: width,
          height: height,
          // Use Image.network with loading and error handling
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(
              pic,
              fit: BoxFit.cover,
              width: width,
              height: height,
              loadingBuilder: (context, child, progress) {
                // Display loading spinner while image loads
                return progress == null
                    ? child // Image is fully loaded
                    : const Center(
                        child: CircularProgressIndicator()); // Loading spinner
              },
              errorBuilder: (context, error, stackTrace) {
                // Display fallback image on error
                return Image.asset(
                  'assets/images/vessel.jpg',
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
