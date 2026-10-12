// import 'package:vascular_blood/exports/modules.dart';
// import 'package:vascular_blood/screens/setSize/controller.dart';
// import 'package:vascular_blood/screens/setSize/step_view.dart';
// import 'package:vascular_blood/theme/color.dart';


// class SetDiameterSize extends StatefulWidget {
//   const SetDiameterSize({super.key});

//   @override
//   State<SetDiameterSize> createState() => _SetDiameterSizeState();
// }

// class _SetDiameterSizeState extends State<SetDiameterSize> {
//   int _index = 0;
//   final SizeController sizeController = Get.put(SizeController(),permanent: true);

 
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(60),
//                       bottomRight: Radius.circular(60)),
//                   child: Image.asset(
//                     "assets/images/pattern.jpg",
//                     width: size.width,
//                     height: size.height * 0.3,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical:size.width * 0.015 ,horizontal: size.width * 0.05),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(60),
//                                   color: Colors.white),
//                               child: Icon(
//                                 Icons.arrow_back_ios,
//                                 color: Colors.red,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Icon(
//                         Icons.check_box,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(height: 3),
//                       Text(
//                         "Diameter size",
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleLarge!
//                             .copyWith(color: Colors.white),
//                       ),
//                       const SizedBox(height: 3),
//                       Text(
//                         "Please enter the approximate inner and outer diameter of the artificial vessel",
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                             fontWeight: FontWeight.normal, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   left: size.width * 0.05,
//                   right: size.width * 0.05,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(color: Colors.grey.shade400, blurRadius: 2),
//                       ],
//                       color: Colors.white,
//                       borderRadius: const BorderRadius.all(Radius.circular(30)),
//                     ),
//                     height: size.height * 0.75,
//                     child: Stack(children: [
//                       Positioned(
//                         bottom: 0,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(30),
//                             bottomRight: Radius.circular(30),
//                           ),
//                           child: Image.asset(
//                             "assets/images/pat12.jpg",
//                             // width: MediaQuery.of(context).size.width,
//                             height: size.height * 0.15,
//                             width: size.width - (size.width * 0.1),
//                             fit: BoxFit.fitWidth,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         mainAxisSize:
//                             MainAxisSize.max, // Allows proper expansion
//                         children: [
//                           Expanded(
//                             // Use Expanded instead of Flexible
//                             child: SingleChildScrollView(
//                               // Add scroll functionality
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Stepper(
//                                     connectorColor:
//                                         const WidgetStatePropertyAll(
//                                             Colors.black),
//                                     currentStep: _index,
//                                     onStepCancel: () {
//                                       if (_index > 0) {
//                                         setState(() {
//                                           _index -= 1;
//                                         });
//                                       }
//                                     },
//                                     onStepContinue: () {
//                                       if (_index <= 0) {
//                                         setState(() {
//                                           _index += 1;
//                                         });
//                                       }
//                                     },
//                                     onStepTapped: (int index) {
//                                       setState(() {
//                                         _index = index;
//                                       });
//                                     },
//                                     steps: [
//                                       Step(
//                                         title: const Text(
//                                             "Please select the artificial vessel gauge size (mm)"),
//                                         content: StepesView(
//                                           list: const ['18 ', '21 ', '23 '],
//                                           callback: (value) {
//                                             sizeController.innerSize.value =
//                                                 value.toString();
//                                           },
//                                         ),
//                                       ),
//                                       Step(
//                                         title: const Text(
//                                             "Please select the size of the outer diameter of the artificial vessel (mm)"),
//                                         content: StepesView(
//                                           list: const ['2 ', '4', '6 '],
//                                           callback: (value) {
//                                             sizeController.outerSize.value =
//                                                 value.toString();
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 25),
//                                   Obx(() {
//                                     bool isButtonEnabled =
//                                         sizeController.innerSize.isNotEmpty &&
//                                             sizeController.outerSize.isNotEmpty;

//                                     return ElevatedButton(
//                                       onPressed: isButtonEnabled
//                                           ? () {
//                                               Logger().i(
//                                                   "Inner size is : ${sizeController.innerSize.value} and Outer size is : ${sizeController.outerSize.value}");
//                                               Get.offNamed(Routes.wifi);
//                                             }
//                                           : null,
//                                       style: ButtonStyle(
//                                         backgroundColor: isButtonEnabled
//                                             ? WidgetStateProperty.all(
//                                                 LightThemeColor.primaryColor)
//                                             : WidgetStateProperty.all(
//                                                 Colors.grey),
//                                       ),
//                                       child: Text(
//                                         "Next",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleMedium!
//                                             .copyWith(
//                                                 color: Colors.white,
//                                                 fontSize: size.height * 0.025,
//                                                 fontWeight: FontWeight.w700),
//                                       ),
//                                     );
//                                   }),
//                                   const SizedBox(
//                                       height: 20), // Add some spacing
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ]),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
