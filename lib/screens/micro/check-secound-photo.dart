import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/exports/screens.dart';
import 'package:vascular_blood/storage/getx.dart';

class CheckSecoundImage extends StatelessWidget {
  final MainController controller = Get.find<MainController>();

  CheckSecoundImage({super.key});

  @override
  Widget build(BuildContext context) {
    final img = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Photo Review",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: InkWell(
            onTap: () {
              controller.capturedImages[1] = null;
              controller.capturedImages.refresh();

              Get.toNamed(Routes.micro);
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60), color: Colors.white),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Positioned(
            bottom: -15,
            child: Image.asset(
              'assets/images/pat21.png',
              width: MediaQuery.of(context).size.width,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Image.file(img)
                    //     Image.asset(
                    //   "assets/images/vessel.jpg",
                    //   // height: 150,
                    // ),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              CheckCard(
                title: 'Review and Retry',
                content:
                    "Review the photo. If it’s blurry, low-quality, or not properly aligned, tap 'Retry' to take another one.",
                color: Colors.red,
                func: () {
                  controller.capturedImages[1] = null;
                  controller.capturedImages.refresh();

                  Get.toNamed(Routes.micro);
                },
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              CheckCard(
                  title: 'Next Step',
                  content:
                      "If the image is acceptable, rotate the vessel, position it under the microscope, and press 'Next' to capture from the opposite side",
                  color: Colors.black,
                  func: () {
                    Get.offNamed(Routes.net);
                  })
            ],
          ),
        ),
      ]),
    );
  }
}

class CheckCard extends StatelessWidget {
  const CheckCard({
    super.key,
    required this.title,
    required this.content,
    required this.color,
    required this.func,
  });
  final String title;
  final String content;
  final Color color;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    final String btn = color == Colors.red ? 'Retry' : 'Next';
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      color == Colors.red
                          ? Row(
                              children: [
                                Image.asset(
                                  'assets/images/retry.png',
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  title,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  title,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          minimumSize: const Size(
                              100, 40), // Set a small width and height
                          padding: EdgeInsets.zero, // Remove extra padding
                          textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500), // Reduce text size
                        ),
                        onPressed: func,
                        child: Text(btn),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                          fontSize: 16, // Adjust text size
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
