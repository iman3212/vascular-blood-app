import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vascular_blood/global/globalwidgets/Result/detect_fail.dart';
import 'package:vascular_blood/global/globalwidgets/Result/fail_check.dart';
import 'package:vascular_blood/global/globalwidgets/Result/pass_check.dart';
import 'package:vascular_blood/global/globalwidgets/Result/result_widget1.dart';
import 'package:vascular_blood/global/globalwidgets/Result/result_widget2.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/image-dialog.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/save_data.dart';
import 'package:vascular_blood/routes/route.dart';
import 'package:vascular_blood/screens/result/connection_error.dart';
import 'package:vascular_blood/screens/result/controller.dart';
import 'package:vascular_blood/services/error_handling_view.dart';

class Result extends StatelessWidget {
  Result({super.key});

  final ResultsController reController = Get.put(ResultsController());
  final FlipCardController _controller = FlipCardController();
  var overall = null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxCheck = size.width < 360 ? true : false;

    return WillPopScope(
      onWillPop: () async {
        SaveData().showsaveDialog(id: reController.data.value.diameter.id);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: InkWell(
              onTap: () {
                Get.offNamed(Routes.menu);
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ),

          title: const Text(
            "QC Results",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Padding(
                padding: const EdgeInsets.all(7.0),
                child: InkWell(
                  onTap: () {
                    overall != null
                        ? Get.toNamed(Routes.general, arguments: overall)
                        : print('');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      'assets/images/qc.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                )
                // IconButton(
                //   icon: const Icon(
                //     Icons.table_rows,
                //     color: Colors.white,
                //     size: 30,
                //   ),
                //   onPressed: () {
                //     if (reController.data.value != null) {
                //       print('${reController.data.value.diameter}');
                //       Get.toNamed(Routes.needletable,
                //           arguments: reController.data.value.diameter);
                //     } else {
                //       return;
                //     }
                //   },
                // ),
                )
          ],
        ),
        body: Obx(() {
          if (reController.isLoading.value) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Colors.red,
                size: 28,
              ), // Show loading indicator
            );
          } else if (!reController.isConnected.value) {
            return Disconnection(
              onTryAgain: () {
                reController.aiResult(
                    reController.frontVeinImage, reController.backVeinImage);
              },
            );
          } else if (reController.errorMessage.isNotEmpty ||
              reController.data.value == null) {
            return ErrorPage(size: size);
          } else {
            final isParameter = reController.type == "parameter";

            final resultData = isParameter
                ? reController.data.value.parameter
                : reController.data.value.diameter;

            late bool frontBothNull;
            late bool backBothNull;
            overall = resultData;
            if (isParameter) {
              frontBothNull = (resultData.widthResult == null &&
                  resultData.heightResult == null);
              backBothNull = false; // Set default if not relevant
            } else {
              frontBothNull = (resultData.frontInnerDiameter == null &&
                  resultData.frontExternalDiameter == null);

              backBothNull = (resultData.backInnerDiameter == null &&
                  resultData.backExternalDiameter == null);
            }

            return Stack(children: [
              Positioned(
                  bottom: -120,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/pat2.png',
                    width: MediaQuery.of(context).size.width,
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(20, size.height * 0.015, 20, 2),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuHeader(
                            title: 'Front Side',
                            onTap: () {
                              reController.selectedItem.value = 0;
                              _controller.toggleCard();
                            },
                            flag: reController.selectedItem.value,
                            index: 0,
                          ),
                          MenuHeader(
                            title: 'Back Side',
                            onTap: () {
                              reController.selectedItem.value = 1;
                              _controller.toggleCard();
                            },
                            flag: reController.selectedItem.value,
                            index: 1,
                          ),
                          MenuHeader(
                            title: 'Overall',
                            onTap: () {
                              reController.selectedItem.value = 2;
                              overall != null
                                  ? Get.toNamed(Routes.general,
                                      arguments: overall)
                                  : print('');
                            },
                            flag: reController.selectedItem.value,
                            index: 2,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FlipCard(
                      controller: _controller,
                      flipOnTouch: true,
                      direction: FlipDirection.HORIZONTAL,
                      back: Card1(
                        size: size,
                        maxCheck: maxCheck,
                        data: resultData,
                        isNullCheck: frontBothNull,
                        isParameter: isParameter,
                      ),
                      front: Card2(
                        size: size,
                        maxCheck: maxCheck,
                        data: resultData,
                        isNullCheck: backBothNull,
                        isParameter: isParameter,
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          }
        }),
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
    required this.title,
    required this.onTap,
    required this.flag,
    required this.index,
  });
  final String title;
  final onTap;
  final int flag;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              style: TextStyle(
                  color: flag == index ? Colors.black : Colors.grey,
                  fontSize: 16),
            ),
          )),
    );
  }
}

class Card1 extends StatelessWidget {
  const Card1({
    super.key,
    required this.size,
    required this.maxCheck,
    required this.data,
    required this.isNullCheck,
    required this.isParameter,
  });

  final Size size;
  final bool maxCheck;
  final data;
  final isNullCheck;
  final isParameter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // Consistent borderRadius
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                10), // Same as the Container's borderRadius
            child: InkWell(
              onTap: () {
                final imageUrl = data?.front != null
                    ? 'http://vascular.hitechprojects.ir:8300${data?.front}'
                    : 'assets/images/vessel.jpg';
                showDialog(
                  context: context,
                  builder: (_) => ImageDialog(
                    pic: imageUrl,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'http://vascular.hitechprojects.ir:8300${data?.front}',
                    height: size.height * 0.32, // Responsive height
                    width: size.width, // Full width of screen
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, StackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/vessel.jpg",
                            height: size.height * 0.32, // Responsive height
                            width: size.width, // Full width of screen
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        isNullCheck
            ? Container()
            : const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
        isNullCheck
            ? DetectFail(size: size)
            : Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Avoiding overflow
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              data.frontFlag
                                  ? Pass(size: size)
                                  : Fail(size: size),
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              ResultWidget2(
                                size: size,
                                isParameter: isParameter,
                                resultData: data,
                                side: 0,
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          width: 20,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CenterWidget(
                                size: size,
                                center: data.concentricBack,
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              ResultWidget(
                                size: size,
                                isParameter: isParameter,
                                resultData: data,
                                side: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              )
      ],
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({
    super.key,
    required this.size,
    required this.maxCheck,
    required this.data,
    required this.isNullCheck,
    required this.isParameter,
  });

  final Size size;
  final bool maxCheck;
  final data;
  final isNullCheck;
  final isParameter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // Consistent borderRadius
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                10), // Same as the Container's borderRadius
            child: InkWell(
              onTap: () {
                final imageUrl = data?.back != null
                    ? 'http://vascular.hitechprojects.ir:8300${data?.back}'
                    : 'assets/images/vessel.jpg';
                showDialog(
                  context: context,
                  builder: (_) => ImageDialog(
                    pic: imageUrl,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'http://vascular.hitechprojects.ir:8300${data?.back}',
                    height: size.height * 0.32, // Responsive height
                    width: size.width, // Full width of screen
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, StackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/vessel.jpg",
                            height: size.height * 0.32, // Responsive height
                            width: size.width, // Full width of screen
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        isNullCheck
            ? Container()
            : const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
        isNullCheck
            ? DetectFail(size: size)
            : Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Avoiding overflow
                children: [
                  Container(
                    height: size.height * 0.4, // Fixed height

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              data.backFlag
                                  ? Pass(size: size)
                                  : Fail(size: size),
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              ResultWidget2(
                                size: size,
                                isParameter: isParameter,
                                resultData: data,
                                side: 1,
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          width: 20,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CenterWidget(
                                size: size,
                                center: data.concentricFront,
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              ResultWidget(
                                size: size,
                                isParameter: isParameter,
                                resultData: data,
                                side: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              )
      ],
    );
  }
}

class CenterWidget extends StatelessWidget {
  const CenterWidget({
    super.key,
    required this.size,
    required this.center,
  });

  final Size size;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Color statusColor = center ? Colors.green : Colors.red;
    final String statusText = center ? "YES" : "NO";
    return Container(
      height: size.height * 0.17,
      width: size.width * 0.43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/images/center.png",
                        width: size.width * 0.06,
                        height: size.width * 0.06,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "Centrality",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Located at the center",
              style: textTheme.bodySmall!.copyWith(color: Colors.grey.shade700),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Divider(color: Colors.grey.shade300),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: statusColor,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        statusText,
                        style: textTheme.bodySmall!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
