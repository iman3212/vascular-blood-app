import 'package:flutter/services.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/exports/screens.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/instruction.dart';
import 'package:vascular_blood/screens/micro/controller.dart';

//http ui
// class MicroStream extends StatelessWidget {
//   final MicroController controller = Get.put(MicroController());

//   MicroStream({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen size
//     final screenSize = MediaQuery.of(context).size;
//     final centerX = screenSize.width / 2;
//     final centerY = screenSize.height / 2;

//     return WillPopScope(
//       onWillPop: () async {
//         controller.dispose();
//         SystemChrome.setPreferredOrientations([
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ]);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Stack(
//           children: [
//             StreamBuilder<Image>(
//               stream: controller.imageStreamController.stream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           "assets/gifs/load1.gif",
//                           height: 300,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           "Loading ...",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       'Error: ${snapshot.error}',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   );
//                 } else if (snapshot.hasData) {
//                   return Center(
//                     child: ClipRRect(
//                       child:
//                           FittedBox(fit: BoxFit.contain, child: snapshot.data!),
//                     ),
//                   );
//                 } else {
//                   return const Center(
//                     child: Text(
//                       'No data received',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }
//               },
//             ),
//             Positioned(
//               top: 20,
//               left: 10,
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: InkWell(
//                   onTap: () {
//                     controller.dispose();

//                     Get.back();
//                     SystemChrome.setPreferredOrientations([
//                       DeviceOrientation.portraitUp,
//                       DeviceOrientation.portraitDown,
//                     ]);
//                   },
//                   child: Container(
//                     width: 35,
//                     height: 35,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(60),
//                       color: Colors.red,
//                     ),
//                     child: const Center(
//                       child: Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               top: 0,
//               right: 10,
//               child: Container(
//                 width: 100,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         InstructionDialog()
//                             .showInstructionDialog(isLandScape: true);
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(80),
//                         ),
//                         child: const Icon(
//                           Icons.library_books,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 45,
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         print(controller.isButtonEnabled.value);
//                         if (controller.isButtonEnabled.value) {
//                           await controller.createImageFile();
//                         }
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(60),
//                           border: Border.all(color: Colors.red),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 60,
//                             width: 60,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(80),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 45,
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Obx(
//                         () => Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             color: controller.successfullImage.value
//                                 ? Colors.green
//                                 : Colors.red,
//                             borderRadius: BorderRadius.circular(80),
//                           ),
//                           child: const Icon(
//                             Icons.check,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Add the icon at the center of the screen
//             Positioned(
//               left: centerX - 20, // Adjust for the icon size
//               top: centerY - 20, // Adjust for the icon size
//               child: const Icon(
//                 Icons.center_focus_strong,
//                 color: Colors.red,
//                 size: 40,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// udp ui (microscope in hitech)
class MicroStream extends StatelessWidget {
  final MicroController controller =
      Get.put(MicroController(), permanent: true);

  MicroStream({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Obx(
              () =>
               Center(
                child: controller.imageData.isNotEmpty
                    ? Container(
                       
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(19),
                          child: Image.memory(
                            height: MediaQuery.of(context).size.height,
                            Uint8List.fromList(controller.imageData.value),
                            gaplessPlayback: true,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/gifs/load.gif",
                            height: 300,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Loading ...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
              ),
            ),
            Positioned(
                top: 20,
                left: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeRight,
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.red),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              top: 0,
              right: 10,
              child: Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        InstructionDialog()
                            .showInstructionDialog(isLandScape: true);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: const Icon(
                          Icons.library_books,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    InkWell(
                      onTap: () async {
                        print(controller.isButtonEnabled.value);
                        if (controller.isButtonEnabled.value) {
                          // udp
                         await controller.createImageFile();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(color: Colors.red)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(80),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Obx(
                        () => Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: controller.successfullImage.value
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Add the icon at the center of the screen
            Positioned(
              left: centerX - 20, // Adjust for the icon size
              top: centerY - 20, // Adjust for the icon size
              child: const Icon(
                Icons.center_focus_strong,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

